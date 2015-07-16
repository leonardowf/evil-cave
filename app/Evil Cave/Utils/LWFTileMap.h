//
//  LWFTileMap.h
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWFMapDimension;
@class LWFTile;
@class LWFRect;

@interface LWFTileMap : NSObject

@property (nonatomic, strong) NSMutableArray *tiles;
@property (nonatomic, strong) NSMutableArray *gridModel;
@property (nonatomic, strong) LWFTile *startTile;
@property (nonatomic, strong) LWFTile *endTile;
@property (nonatomic, strong) LWFRect *startingRoom;
@property (nonatomic, strong) LWFRect *endingRoom;
@property (nonatomic, strong) LWFMapDimension *mapDimension;


- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension;
- (LWFTile *)tileForVertical:(NSInteger)vertical andHorizontal:(NSInteger)horizontal;
- (NSArray *)neighborsForTile:(LWFTile *)tile;
- (LWFTile *)randomEmptyWalkableTile;
- (LWFTile *)randomEmptyWalkableTileNotInStartAndEnd;
- (LWFTile *)closestNeighborFromTile:(LWFTile *)origin toTile:(LWFTile *)destiny;
- (BOOL)isInBoundsTheTileWithX:(NSUInteger)x andY:(NSUInteger)y;
- (LWFTile *)randomEmptyWalkableTileNotInStartAndEndWithWalkableAdjacents:(NSInteger)numberOfAdjacentsRequired;
- (BOOL)tile:(LWFTile *)possibleAdjacent isAdjacentTo:(LWFTile *)target;

@end
