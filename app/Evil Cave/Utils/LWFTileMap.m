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
#import "LWFPathFinder.h"

@implementation LWFTileMap

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension
{
    self = [super init];
    if (self) {
        self.mapDimension = mapDimension;
        
        LWFCaveGenerator *generator = [[LWFCaveGenerator alloc]initWithHeight:mapDimension.numberTilesHorizontal width:mapDimension.numberTilesVertical];
        self.gridModel = [generator generate];
        
        self.tiles = [[NSMutableArray alloc]initWithCapacity:mapDimension.numberTilesVertical];
        NSInteger i = 0;
        for (i = 0; i < mapDimension.numberTilesVertical; i++) {
            self.tiles[i] = [[NSMutableArray alloc]initWithCapacity:mapDimension.numberTilesHorizontal];
            
            for (NSInteger j = 0; j < mapDimension.numberTilesHorizontal; j++) {
                LWFCaveGeneratorCell *cell = _gridModel[i][j];
                
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
                tile.position = CGPointMake(j * mapDimension.tileSize.height, i * mapDimension.tileSize.height);
                tile.x = i;
                tile.y = j;
                
                self.tiles[i][j] = tile;
            }
        }
    }
    return self;
}

- (LWFTile *)tileForVertical:(NSInteger)vertical andHorizontal:(NSInteger)horizontal {
    LWFTile *result;
    
    if (vertical < 0 || vertical >= self.mapDimension.numberTilesVertical || horizontal < 0 || horizontal >= self.mapDimension.numberTilesHorizontal) {
        return nil;
    }
    
    result = self.tiles[vertical][horizontal];
    
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



@end
