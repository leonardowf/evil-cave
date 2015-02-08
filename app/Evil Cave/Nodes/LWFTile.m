//
//  LWFTile.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFTile.h"
#import "LWFRandomUtils.h"
#import "LWFItem.h"
#import "LWFCreature.h"
#import "LWFPlayer.h"

@implementation LWFTile

- (instancetype)initWithTexture:(SKTexture *)texture
{
    self = [super initWithTexture:texture];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isPassable {
    return [self isWalkable] && self.creatureOnTile == nil;
}

- (NSUInteger)distanceToTile:(LWFTile *)tile {
    NSInteger dx = self.x - tile.x;
    NSInteger dy = self.y - tile.y;
    
    dx = dx * dx;
    dy = dy * dy;
    
    return sqrt(dx + dy);
}

- (void)steppedOnTile:(LWFCreature *)creature {
    BOOL isPlayer = [creature isKindOfClass:[LWFPlayer class]];
    
    if (self.cellType == CaveCellTypeDoor) {
        SKTexture *texture = [SKTexture textureWithImageNamed:@"door_open"];
        texture.filteringMode = SKTextureFilteringNearest;
        [self setTexture:texture];
    }
    
    if (isPlayer) {
        
        // Decide se é gold, caso sim, pega automaticamente
        NSMutableArray *toRemove = [NSMutableArray array];
        
        for (LWFItem *item in self.items) {
            if ([item isMoney]) {
                [toRemove addObject:item];
            }
        }
        
        NSInteger totalGold = 0;
        for (LWFItem *gold in toRemove) {
            totalGold = totalGold + gold.quantity;
        }
        
        if (totalGold > 0) {
            LWFItem *pileOfGold = [toRemove firstObject];
            pileOfGold.quantity = totalGold;
            LWFPlayer *player = (LWFPlayer *)creature;
            [player takeItem:pileOfGold];
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
    
    NSString *textureName = [NSString stringWithFormat:@"blood_%d", randomized];
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

@end
