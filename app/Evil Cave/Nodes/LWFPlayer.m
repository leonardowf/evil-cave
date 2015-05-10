 //
//  LWFPlayer.m
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFPlayer.h"
#import "LWFTile.h"
#import "LWFMap.h"
#import "LWFTurnList.h"
#import "LWFInventory.h"
#import "LWFSpinningAttack.h"
#import "LWFAttackManager.h"
#import "LWFShadowCasting.h"
#import "LWFHudLifebar.h"

#import "LWFOTEQueue.h"
#import "LWFOTESpinningCooldown.h"
#import "LWFGold.h"

@implementation LWFPlayer

SINGLETON_FOR_CLASS(Player)

- (void)build {
    [super build];
    
    self.inventory = [LWFInventory sharedInventory];
}

- (void)moveCameraToTile:(LWFTile *)tile {
    [self.map moveCameraToTile:tile];
}

- (BOOL)shouldFinishTurnOnFailedMovement {
    return NO;
}

- (void)notifyMovementFailure {
    NSLog(@"Player falhou na hora de mover");
    [self cancelPreExistingActions];
    [self.map unlockUserInteraction];
}

- (void)processTurn {
    [self.map newTurnCycleStarted];
    
    [self.oteQueue process];
    
    if (self.tilePath == nil || self.tilePath.count == 0) {
        [self.map unlockUserInteraction];
    } else if (self.tilePath.count > 0) {
        [self walkToExistingPath];
    }
    
    [self.map processTouchQueue];
}

- (void)moveableToTile:(LWFTile *)tile {
    [self moveToTile:tile completion:^{
        [self didMoveToTile:tile atX:tile.x andY:tile.y];
    }];
}

- (void)moveToTile:(LWFTile *)tile completion:(void(^)(void))someBlock {
    [super moveToTile:tile completion:someBlock];
    [self moveCameraToTile:tile];

}

- (void)didMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    [tile steppedOnTile:self];
    
    [self.tilePath removeObject:tile];
    
    [self doFov];
    
    if (tile.cellType != CaveCellTypeEnd) {
        [self finishTurn];
    }
}

- (void)doFov {
    LWFTile *tile = self.currentTile;
    LWFShadowCasting *shadowCasting = [[LWFShadowCasting alloc]init];
    [shadowCasting doFovStartX:tile.x startY:tile.y radius:5];
}

- (void)movementRequestIsInvalid {
    [self.map movementRequestIsInvalid];
}

- (void)willAttackTile:(LWFTile *)tile withAttack:(LWFAttack *)attack completion:(void (^)(void))someBlock {
    if ([attack isKindOfClass:[LWFSpinningAttack class]]) {
        [someBlock invoke];
        return;
    }
    
    
    [super willAttackTile:tile withAttack:attack completion:nil];
    
    [self startAttackingAnimation];
    
    [someBlock invoke];
}

- (void)startAttackingAnimation {
    NSArray *attackingFramesAnimation = [self getAttackingFramesAnimation];
    
    [self removeActionForKey:@"attacking_action"];
    
    if (attackingFramesAnimation != nil && attackingFramesAnimation.count > 0) {
        SKAction *animate = [SKAction animateWithTextures:attackingFramesAnimation timePerFrame:0.15f resize:NO restore:YES];
        SKAction *action = [SKAction repeatAction:animate count:2];
        
        [self runAction:action];
    }
}

- (NSArray *)getAttackingFramesAnimation {

    NSMutableArray *attackingAtlasArray = [NSMutableArray array];
    NSString *attackingAtlasName = [NSString stringWithFormat:@"%@_attacking_%@", self.spriteImageName, self.currentFacingDirection];
    SKTextureAtlas *attackingAtlas = [SKTextureAtlas atlasNamed:attackingAtlasName];
    
    NSUInteger numImages = attackingAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", attackingAtlasName, i];
        SKTexture *texture = [attackingAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [attackingAtlasArray addObject:texture];
    }
    
    return attackingAtlasArray;

}

- (NSArray *)getDyingFramesAnimation {
    return nil;
}

- (void)cancelPreExistingActions {
    self.tilePath = nil;
}

- (void)takeItem:(LWFNewItem *)item {
    if ([item isGold]) {
        LWFGold *gold = (LWFGold *)item;
        
        SKLabelNode *label = [gold getLabel];
        
        label.position = self.currentTile.position;
        
        [self.map addChild:label];
        
        SKAction *action = [SKAction moveByX:0 y:70 duration:1.2];
        [label runAction:action completion:^{
            SKAction *action = [SKAction fadeAlphaTo:0 duration:0.2];
            [label runAction:action completion:^{
            }];
            
        }];
        
        self.inventory.money = self.inventory.money + item.quantity;
        [LWFLogger logGold:item.quantity];
        
        
    } else {
        // TODO: Potion
        [self.inventory takeItem:item];
        
        // Esse é um dos comportamentos mais bizarros que já na minha experiên-
        // cia de programador. Quando chamo o remove object, está sendo removi-
        // do dois objetos do array .currentTile.items
        // O workaround foi adicionar pelo arrayTemp WTF
//        [self.currentTile.items removeObject:item];
//        NSMutableArray *wtf = [NSMutableArray arrayWithArray:self.currentTile.items];
        
        NSMutableArray *wtf = [NSMutableArray array];
        
        NSArray *items = self.currentTile.items;
        for (LWFNewItem *aItem in items) {
            if (aItem != item) {
                [wtf addObject:aItem];
            }
        }
        
        self.currentTile.items = wtf;
        
        [item removeFromParent];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"notificationShowItemPreview"
         object:self.currentTile.items];
    }
}

- (void)requestTakeItem {
    if (self.currentTile.items == nil || self.currentTile.items.count == 0) {
        return;
    }
    
    LWFNewItem *item = [self.currentTile.items lastObject];
    
    if ([self.inventory canTakeItem:item]) {
        [self takeItem:item];
    }
    
    [self finishTurn];
}

- (void)receveidDamageLog:(NSInteger)damage fromCreature:(LWFCreature *)creature {
    [LWFLogger logAttackedBy:creature damage:damage];
}

- (void)requestSpecialAttack {        
//    SKAction *rotation = [SKAction rotateByAngle: 2*M_PI duration:0.3];
//    //and just run the action
//    [self runAction: rotation];
    
//    tilesize ---- 100
    // 48 --- x
    
    float x = 48.0 * 100.0 / TILE_SIZE + 10;
    
    [self setSize:CGSizeMake(x, x)];
    
    NSArray *spinningAnimation = [self getSpinningAttackFrames];
    
    if (spinningAnimation != nil && spinningAnimation.count > 0) {
        SKAction *animate = [SKAction animateWithTextures:spinningAnimation timePerFrame:0.05f resize:NO restore:YES];
        SKAction *action = [SKAction repeatAction:animate count:1];
        
        [self runAction:action completion:^{
            [self setSize:CGSizeMake(TILE_SIZE, TILE_SIZE)];
            LWFSpinningAttack *spinningAttack = [[LWFSpinningAttack alloc]init];
            [self.attackManager attackable:self requestedAttackToTile:self.currentTile withAttack:spinningAttack];
        }];
    }
    
    
    

    
}

- (id<LWFLifeDisplayer>)getLifeBar {
    return [LWFHudLifebar sharedHudLifeBar];
}

- (LWFEquips *)getEquips {
    return self.inventory.equips;
}

- (NSArray *)getSpinningAttackFrames {
    NSMutableArray *spinningAtlasArray = [NSMutableArray array];
    NSString *spinningAtlasName = [NSString stringWithFormat:@"warrior_spinning_attack_right"];
    SKTextureAtlas *spinningAtlas = [SKTextureAtlas atlasNamed:spinningAtlasName];
    
    NSUInteger numImages = spinningAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"spin_attack%d", i];
        SKTexture *texture = [spinningAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [spinningAtlasArray addObject:texture];
    }
    
    return spinningAtlasArray;
}


@end
