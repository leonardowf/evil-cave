//
//  LWFCreature.m
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCreature.h"
#import "LWFMovementManager.h"

@implementation LWFCreature

- (void)requestMoveToTileAtX:(NSUInteger)x andY:(NSUInteger)y {
    [self.movementManager moveable:self requestMoveToTileAtX:x andY:y];
}

- (void)willMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y; {
    
}

- (void)failedToMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    
}
- (void)didMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    
}

- (void)updateCurrentTile:(LWFTile *)currentTile {
    self.currentTile = currentTile;
}

- (void)moveToTile:(LWFTile *)tile {
    SKAction *moveAction = [SKAction moveTo:tile.position duration:0.2];
    [self runAction: moveAction];
}

- (void)build {
    [self setTexture:[SKTexture textureWithImage:[UIImage imageNamed:self.spriteImageName]]];
    [self setSize:CGSizeMake(32, 32)];
}


@end
