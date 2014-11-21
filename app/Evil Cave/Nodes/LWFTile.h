//
//  LWFTile.h
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LWFTile : SKSpriteNode

@property (getter = isWalkable, setter = setWalkable:) BOOL walkable;

- (BOOL)isPassable;

@end
