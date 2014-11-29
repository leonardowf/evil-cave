//
//  LWFTileMap.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFTileMap.h"
#import "LWFMapDimension.h"
#import "LWFTile.h"
#import "LWFCaveGenerator.h"
#import "LWFRandomUtils.h"

@implementation LWFTileMap

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension
{
    self = [super init];
    if (self) {
        self.mapDimension = mapDimension;
        
        LWFCaveGenerator *generator = [[LWFCaveGenerator alloc]initWithHeight:mapDimension.numberTilesVertical width:mapDimension.numberTilesHorizontal];
        self.gridModel = [generator generate];
        
        self.tiles = [[NSMutableArray alloc]initWithCapacity:mapDimension.numberTilesHorizontal];
        NSInteger x = 0;
        for (x = 0; x < mapDimension.numberTilesHorizontal; x++) {
            self.tiles[x] = [[NSMutableArray alloc]initWithCapacity:mapDimension.numberTilesVertical];
            
            for (NSInteger y = 0; y < mapDimension.numberTilesVertical; y++) {
                LWFCaveGeneratorCell *cell = _gridModel[x][y];
                
                LWFTile *tile;
                if (cell == nil) {
                    tile = [[LWFTile alloc]initWithColor:[UIColor blackColor] size:mapDimension.tileSize];
                    [tile setWalkable:NO];
                }
                else if (cell.cellType == CaveCellTypeFloor) {
                    tile = [[LWFTile alloc]initWithImageNamed:@"cobble_blood1"];
                    [tile setWalkable:YES];
                } else if (cell.cellType == CaveCellTypeStart) {
                    tile = [[LWFTile alloc]initWithColor:[UIColor redColor] size:mapDimension.tileSize];
                    [tile setWalkable:YES];
                    self.startTile = tile;
                } else if (cell.cellType == CaveCellTypeEnd) {
                    tile = [[LWFTile alloc]initWithColor:[UIColor greenColor] size:mapDimension.tileSize];
                    [tile setWalkable:YES];
                    self.endTile = tile;
                    
                } else {
                    tile = [[LWFTile alloc]initWithColor:[UIColor blackColor] size:mapDimension.tileSize];
                    [tile setWalkable:NO];
                }
                
                tile.size = mapDimension.tileSize;
                tile.position = CGPointMake(x * mapDimension.tileSize.height, y * mapDimension.tileSize.height);
                tile.x = x;
                tile.y = y;
                
                self.tiles[x][y] = tile;
            }
        }
    }
    return self;
}

- (LWFTile *)tileForVertical:(NSInteger)y andHorizontal:(NSInteger)x {
    LWFTile *result;
    
    if (x < 0 || x >= self.mapDimension.numberTilesHorizontal || y < 0 || y >= self.mapDimension.numberTilesVertical) {
        return nil;
    }
    
    result = self.tiles[x][y];
    
    return result;
}

- (NSArray *)neighborsForTile:(LWFTile *)tile {
    NSMutableArray *neighbors = [NSMutableArray array];
    
    NSUInteger x = tile.x;
    NSUInteger y = tile.y;
    
    NSInteger northX = x;
    NSInteger northY = y + 1;
    
    NSInteger southX = x;
    NSInteger southY = y - 1;
    
    NSInteger eastX = x + 1;
    NSInteger eastY = y;
    
    NSInteger westX = x - 1;
    NSInteger westY = y;
    
    LWFTile *chekingTile;
    
    if (southY >= 0) {
        chekingTile = self.tiles[southX][southY];
        [neighbors addObject:chekingTile];
    }
    
    if (northY < self.mapDimension.numberTilesVertical) {
        chekingTile = self.tiles[northX][northY];
        [neighbors addObject:chekingTile];
    }
    
    if (eastX < self.mapDimension.numberTilesHorizontal) {
        chekingTile = self.tiles[eastX][eastY];
        [neighbors addObject:chekingTile];
    }
    
    if (westX >= 0) {
        chekingTile = self.tiles[westX][westY];
        [neighbors addObject:chekingTile];
    }
    
    return neighbors;
}

- (LWFTile *)randomEmptyWalkableTile {
    LWFRandomUtils *randomUtils = [[LWFRandomUtils alloc]init];
    
    LWFTile *tile;
    
    while (tile == nil || ![tile isWalkable] || tile.creatureOnTile != nil) {
        NSUInteger x = [randomUtils randomIntegerBetween:0 and:_mapDimension.numberTilesHorizontal];
        NSUInteger y = [randomUtils randomIntegerBetween:0 and:_mapDimension.numberTilesVertical];
        
        tile = [self tileForVertical:y andHorizontal:x];
    }
    
    return tile;
}

- (LWFTile *)closestNeighborFromTile:(LWFTile *)origin toTile:(LWFTile *)destiny {
    NSArray *neighbors = [self neighborsForTile:destiny];
    
    LWFTile *result;
    NSUInteger closest = 9999;
    
    for(LWFTile *neighbor in neighbors) {
        NSUInteger distanceToTile = [origin distanceToTile:neighbor];
        if (distanceToTile < closest && [neighbor isPassable]) {
            closest = distanceToTile;
            result = neighbor;
        }
    }
    
    return result;
}



@end
