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

@implementation LWFPlayer

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
    [self.map unlockUserInteraction];
}

- (void)processTurn {
    [self.map newTurnCycleStarted];
    
    if (self.tilePath == nil || self.tilePath.count == 0) {
        [self.map unlockUserInteraction];
    } else if (self.tilePath.count > 0) {
        [self walkToExistingPath];
    }
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

- (void)movementRequestIsInvalid {
    [self.map movementRequestIsInvalid];
}

- (void)willAttackTile:(LWFTile *)tile withAttack:(LWFAttack *)attack completion:(void (^)(void))someBlock {
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

@end
