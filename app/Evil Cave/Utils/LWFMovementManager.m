//
//  LWFMovementManager.m
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFMovementManager.h"
#import "LWFTileMap.h"
#import "LWFPlayer.h"

@implementation LWFMovementManager

- (instancetype)initWithTileMap:(LWFTileMap *)tileMap
{
    self = [super init];
    if (self) {
        self.tileMap = tileMap;
    }
    return self;
}

- (void)moveable:(id<LWFMoveable>)moveable requestMoveToTileAtX:(NSUInteger)x andY:(NSUInteger)y {
    LWFTile *tile = [self.tileMap tileForVertical:y andHorizontal:x];
    
    BOOL moveableIsPlayer = [moveable isKindOfClass:[LWFPlayer class]];
    
    if (moveableIsPlayer) {
        LWFPlayer *player = (LWFPlayer *)moveable;
        NSUInteger distanceFromTiles = [tile distanceToTile:player.currentTile];
        
        if (distanceFromTiles > 1) {
            [player buildPathToTile:tile];
            
            if (player.tilePath == nil || player.tilePath.count == 0) {
                [player movementRequestIsInvalid];
            } else {
                [player processTurn];
            }
            
            return;
        }
    }
    
    if (tile.isPassable) {
        [moveable willMoveToTile:tile atX:x andY:y];
//        [moveable moveToTile:tile];
        [moveable updateCurrentTile:tile];
        
        if (!moveableIsPlayer) {
            [moveable didMoveToTile:tile atX:x andY:y];
        }
        
    } else {
        [moveable failedToMoveToTile:tile atX:x andY:y];
    }
}

@end
