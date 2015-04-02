//
//  LWFPoopThrowerRat.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/31/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPoopThrowerRat.h"
#import "LWFPoopThrowAttack.h"
#import "LWFPlayer.h"
#import "LWFMap.h"

@implementation LWFPoopThrowerRat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spriteImageName = @"poop_thrower_rat";
    }
    return self;
}

- (void)build {
    [super build];
}

- (void)processTurn {
    if ([self isDead]) {
        [self finishTurn];
        return;
    }
    
    LWFPoopThrowAttack *poopThrowAttack = [self.attacks firstObject];
    
    if ([poopThrowAttack isCreature:self.player inRangeOfTile:self.currentTile]) {
        [self requestAttackToTile:self.player.currentTile withAttack:poopThrowAttack];
    } else {
        [self finishTurn];
        return;
    }
}

- (NSArray *)getWalkingFramesAnimation {
    return nil;
}

- (NSArray *)getAttackingFramesAnimation {
    return nil;
}

- (void)willAttackTile:(LWFTile *)tile
            withAttack:(LWFAttack *)attack completion:(void(^)(void))someBlock {
    
    NSInteger moveOffsetX = tile.position.x - self.position.x;
    NSInteger moveOffsetY = tile.position.y - self.position.y;
    
    SKSpriteNode *poop = [SKSpriteNode spriteNodeWithImageNamed:@"poop.jpg"];
    [poop setSize:CGSizeMake(TILE_SIZE, TILE_SIZE)];
    [poop setPosition:self.currentTile.position];
    [self.map addChild:poop];
    
    SKAction *action = [SKAction moveBy:CGVectorMake(moveOffsetX, moveOffsetY) duration:0.2];
    [poop runAction:action completion:^{
        [self startStandingAnimation];
        [poop runAction:[SKAction fadeAlphaTo:0 duration:0.1] completion:someBlock];
    }];
}

@end
