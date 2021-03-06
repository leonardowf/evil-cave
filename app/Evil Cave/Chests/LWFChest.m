//
//  LWFChest.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/3/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

typedef enum : NSUInteger {
    LWFChestStateClosed,
    LWFChestStateOpen
} LWFChestState;

#import "LWFChest.h"
#import "LWFLootExplosion.h"
#import "LWFTile.h"
#import "LWFTileMap.h"
#import "LWFPlayer.h"
#import "LWFGameController.h"

@interface LWFChest () {
    LWFChestState _chestState;
}
@end

@implementation LWFChest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isOpen {
    return _chestState == LWFChestStateOpen;
}

- (BOOL)isClosed {
    return _chestState == LWFChestStateClosed;
}

- (void)open {
    _chestState = LWFChestStateOpen;
    
    [self startAnimation:LWFChestAnimationTypeOpening completion:^{
        LWFLootExplosion *lootExplosion = [[LWFLootExplosion alloc]initWithItems:self.items atTile:self.tile];
        [lootExplosion explodeWithCompletion:nil];
    }];
}

- (BOOL)canInteract {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    LWFTileMap *tileMap = [[LWFGameController sharedGameController] tileMap];
    BOOL playerAdjacent = [tileMap tile:player.currentTile isAdjacentTo:self.tile];
    
    return [self isClosed] && playerAdjacent;
}

- (void)interact {
    [self open];
}

#pragma mark - Animations

- (void)startAnimation:(LWFChestAnimationType)animationType completion:(void(^)(void))someBlock {
    switch (animationType) {
        case LWFChestAnimationTypeClosed:
            [self startAnimationClosed];
            break;
        case LWFChestAnimationTypeOpening: {
            [self startOpenAnimationWithCompletion:someBlock];
            break;
        }
        default:
            break;
    }
}

- (void)startAnimationClosed {
    NSMutableArray *closedAtlasArray = [NSMutableArray array];
    NSString *closedAtlasName = @"closed_chest";
    SKTextureAtlas *closedAtlas = [SKTextureAtlas atlasNamed:closedAtlasName];
    
    NSUInteger numImages = closedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", closedAtlasName, i];
        SKTexture *texture = [closedAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [closedAtlasArray addObject:texture];
    }
    
    SKAction *animate = [SKAction animateWithTextures:closedAtlasArray timePerFrame:0.1f];
    SKAction *action = [SKAction repeatActionForever:animate];
    
    [self runAction:action];
}

// TODO: repetido
- (void)startOpenAnimationWithCompletion:(void(^)(void))someBlock {
    [self removeAllActions];
    
    NSMutableArray *closedAtlasArray = [NSMutableArray array];
    NSString *closedAtlasName = @"opening_chest";
    SKTextureAtlas *closedAtlas = [SKTextureAtlas atlasNamed:closedAtlasName];
    
    NSUInteger numImages = closedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", closedAtlasName, i];
        SKTexture *texture = [closedAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [closedAtlasArray addObject:texture];
    }
    
    SKTexture *texture = [SKTexture textureWithImageNamed:@"opened_chest"];
    texture.filteringMode = SKTextureFilteringNearest;
    SKAction *animate = [SKAction animateWithTextures:closedAtlasArray timePerFrame:0.2f];
    
    [self runAction:animate completion:someBlock];
}

@end
