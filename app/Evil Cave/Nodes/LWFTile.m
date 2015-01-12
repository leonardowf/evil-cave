//
//  LWFTile.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFTile.h"

@implementation LWFTile

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
    if (self.cellType == CaveCellTypeDoor) {
        SKTexture *texture = [SKTexture textureWithImageNamed:@"door_open"];
        texture.filteringMode = SKTextureFilteringNearest;
        [self setTexture:texture];
    }
}

@end
