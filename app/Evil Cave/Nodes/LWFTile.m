//
//  LWFTile.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFTile.h"
#import "LWFGameController.h"
#import "LWFRandomUtils.h"
#import "LWFCreature.h"
#import "LWFPlayer.h"
#import "LWFMap.h"
#import "LWFItem.h"
#import "LWFGold.h"
#import "LWFChest.h"

@interface LWFTile () {
    LWFMap *_map;
}
@end

@implementation LWFTile

- (instancetype)initWithTexture:(SKTexture *)texture
{
    self = [super initWithTexture:texture];
    if (self) {
        LWFGameController *gameController = [LWFGameController sharedGameController];
        _map = gameController.map;

        self.items = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isPassable {
    return [self isWalkable] && self.creatureOnTile == nil && self.chest == nil;
}

- (NSUInteger)distanceToTile:(LWFTile *)tile {
    NSInteger dx = self.x - tile.x;
    NSInteger dy = self.y - tile.y;
    
    dx = dx * dx;
    dy = dy * dy;
    
    return sqrt(dx + dy);
}

- (void)steppedOnTile:(LWFCreature *)creature {
    if ([self isLit]) {
        [creature light];
    } else {
        
    }
    
    BOOL isPlayer = [creature isKindOfClass:[LWFPlayer class]];
    
    if (self.cellType == CaveCellTypeDoor) {
        self.doorIsOpen = YES;
        SKTexture *texture = [SKTexture textureWithImageNamed:@"door_open"];
        texture.filteringMode = SKTextureFilteringNearest;
        [self setTexture:texture];
    }
    
    if (isPlayer) {
        
        // Decide se é gold, caso sim, pega automaticamente
        NSMutableArray *toRemove = [NSMutableArray array];
        
        for (LWFItem *item in self.items) {
            if ([item isGold]) {
                [toRemove addObject:item];
            }
        }
        
        for (LWFGold *gold in toRemove) {
            LWFPlayer *player = (LWFPlayer *)creature;
            [player takeItem:gold];
        }
        
        [self.items removeObjectsInArray:toRemove];
        [self removeChildrenInArray:toRemove];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"notificationShowItemPreview"
         object:self.items];
        
    }
    
    if (self.cellType == CaveCellTypeEnd && isPlayer) {
        LWFPlayer *player = (LWFPlayer*)creature;
        [player cancelPreExistingActions];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"notificationNextLevel"
         object:nil];
        NSLog(@"pisou num tile de end");
    }
}

- (void)addLoot:(NSArray *)loot animated:(BOOL)animated {
    NSArray *removedGrouped = [self groupItemsForLoot:loot];
    
    for (LWFItem *item in removedGrouped) {
        
        if (animated) {
            [self addChild:item];
        } else {
            [self addChildNoAnimation:item];
        }
    }
    
    if ([self.creatureOnTile isKindOfClass:[LWFPlayer class]]) {
        [self steppedOnTile:[LWFPlayer sharedPlayer]];
    }
}

- (NSArray *)groupItemsForLoot:(NSArray *)loot {
    // agrupa todos os items no tile se necessário,
    // retornando o loot com os agrupados removidos
    
    NSMutableArray *resultLoot = [NSMutableArray array];
    
    for (LWFItem *item in loot) {
        BOOL didGroup = [self groupItemsForItem:item];
        
        if (!didGroup) {
            [resultLoot addObject:item];
        }
    }
    
    return resultLoot;
}

- (BOOL)groupItemsForItem:(LWFItem *)item {
    // verifica se tem um item no tile
    // se tiver, aumenta sua quantidade e retorna true dizendo que agrupou
    
    for (LWFItem *tileItem in self.items) {
        if ([tileItem isGold] && [item isGold]) {
            tileItem.quantity += item.quantity;
            return YES;
        }
    }
    
    return NO;
}

- (void)diedOnTile:(LWFCreature *)creature {
    if (self.isThereBloodAlready) {
        return;
    }
    
    self.isThereBloodAlready = YES;
    
    LWFRandomUtils *randomUtils = [[LWFRandomUtils alloc]init];
    
    NSString *bloodAtlasName = [NSString stringWithFormat:@"blood"];
    SKTextureAtlas *dyingAtlas = [SKTextureAtlas atlasNamed:bloodAtlasName];
    NSUInteger numImages = dyingAtlas.textureNames.count;
    
    NSInteger randomized = [randomUtils randomIntegerBetween:1 and:numImages + 1];
    
    NSString *textureName = [NSString stringWithFormat:@"blood_%ld", (long)randomized];
    SKTexture *texture = [dyingAtlas textureNamed:textureName];
    texture.filteringMode = SKTextureFilteringNearest;
    
    SKSpriteNode *bloodNode = [SKSpriteNode spriteNodeWithTexture:texture];
    
    [self addChild:bloodNode];
    
}

- (void)addChild:(SKNode *)node {
    SKAction *fadeAction = nil;
    
    if ([node isKindOfClass:[LWFItem class]]) {
        node.alpha = 0.0;
        fadeAction = [SKAction fadeInWithDuration:0.5];
        [self.items addObject:node];
    }

    [super addChild:node];
    
    if (fadeAction != nil) {
        [node runAction:fadeAction];
    }
}

- (void)addChildNoAnimation:(SKNode *)node {
    if ([node isKindOfClass:[LWFItem class]]) {
        [self.items addObject:node];
    }
    
    [super addChild:node];
}

- (void)light {
    self.lit = YES;
    [self.creatureOnTile light];
    
    SKAction *action = [SKAction fadeAlphaTo:1.0 duration:0.3];
    [self runAction:action];
    
    action = [SKAction fadeAlphaTo:0.0 duration:0.3];
    [self.fog runAction:action];
    
    action = [SKAction fadeAlphaTo:1.0 duration:0.3];
    [self.chest runAction:action];
    self.fog = nil;
}

- (void)displayFog {
    if (self.fog != nil) {
        return;
    }
    
    [self light];
    
    SKSpriteNode *_preLoadedFog = [SKSpriteNode spriteNodeWithImageNamed:@"fog_overlay"];
    _preLoadedFog.size = CGSizeMake(2.5 * TILE_SIZE, 2.5 * TILE_SIZE);
    _preLoadedFog.position = self.position;
    
    [_map addChild:_preLoadedFog];
    self.fog = _preLoadedFog;
    
    self.lit = NO;
    
}

@end
