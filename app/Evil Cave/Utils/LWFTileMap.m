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
                    SKTexture *texture = [SKTexture textureWithImageNamed:@"rock_tile"];
                    texture.filteringMode = SKTextureFilteringNearest;
                    tile = [LWFTile spriteNodeWithTexture:texture];
                    [tile setWalkable:YES];
                } else if (cell.cellType == CaveCellTypeStart) {
                    tile = [[LWFTile alloc]initWithColor:[UIColor redColor] size:mapDimension.tileSize];
                    [tile setWalkable:YES];
                    self.startTile = tile;
                } else if (cell.cellType == CaveCellTypeEnd) {
                    tile = [[LWFTile alloc]initWithColor:[UIColor greenColor] size:mapDimension.tileSize];
                    [tile setWalkable:YES];
                    self.endTile = tile;
                    
                } else if (cell.cellType == CaveCellTypeDoor) {
                    tile = [[LWFTile alloc]initWithColor:[UIColor yellowColor] size:mapDimension.tileSize];
                    [tile setWalkable:YES];
                    
                } else {
                    SKTexture *texture = [SKTexture textureWithImageNamed:@"wall"];
                    texture.filteringMode = SKTextureFilteringNearest;
                    tile = [LWFTile spriteNodeWithTexture:texture];
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
    LWFTile *checkingTile;
    NSMutableArray *neighbors = [NSMutableArray array];
    NSInteger currentX = tile.x;
    NSInteger currentY = tile.y;
    NSInteger x, y, newX, newY;
    
    for(y = -1; y <= 1; y++) {
        newY = currentY + y;
        for(x = -1; x <= 1; x++) {
            newX = currentX + x;
            if(x || y) { // pula 0,0
                if((newX >= 0) && (newY >= 0) && (newX < self.mapDimension.numberTilesHorizontal) && (newY < self.mapDimension.numberTilesVertical)) {
                    checkingTile = self.tiles[newX][newY];
                    [neighbors addObject:checkingTile];
                }
            }
        }
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

- (BOOL)isInBoundsTheTileWithX:(NSUInteger)x andY:(NSUInteger)y {
    BOOL horizontalOk = x < _mapDimension.numberTilesHorizontal;
    BOOL verticalOk = y < _mapDimension.numberTilesVertical;
    
    return horizontalOk && verticalOk;
}



@end
