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
}

- (BOOL)canInteract {
    return true;
}

- (void)interact {
    
}

#pragma mark - Animations

- (void)startAnimation:(LWFChestAnimationType)animationType {
    switch (animationType) {
        case LWFChestAnimationTypeClosed:
            [self startAnimationClosed];
            break;
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

@end
