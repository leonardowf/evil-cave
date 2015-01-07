//
//  LWFTile.h
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LWFCaveGeneratorConstants.h"
@class LWFCreature;

@interface LWFTile : SKSpriteNode

@property (getter = isWalkable, setter = setWalkable:) BOOL walkable;
@property NSUInteger x;
@property NSUInteger y;
@property LWFCreature *creatureOnTile;
@property (nonatomic) CaveCellType cellType;

- (BOOL)isPassable;
- (NSUInteger)distanceToTile:(LWFTile *)tile;

@end
