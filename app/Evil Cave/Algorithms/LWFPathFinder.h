//
//  LWFPathFinder.h
//  Evil Cave
//
//  Created by Leonardo on 11/19/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSAIPathFinding.h"

@class LWFTileMap;
@class LWFCreature;
@class LWFTile;

@interface LWFPathFinder : NSObject <HSAIPathFindingDelegate>

@property LWFCreature *creature;
@property LWFTile *endTile;
@property LWFTileMap *tileMap;

- (void) findPathFrom:(CGPoint)start to:(CGPoint)end;

@end
