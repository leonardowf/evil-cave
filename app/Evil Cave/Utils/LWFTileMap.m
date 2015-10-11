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
#import "LWFEndTile.h"
#import "LWFCaveGenerator.h"
#import "LWFRandomUtils.h"
#import "LWFCaveGeneratorResult.h"
#import "LWFRect.h"
#import "LWFCaveGeneratorConstants.h"

@implementation LWFTileMap

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension
{
    self = [super init];
    if (self) {
        self.mapDimension = mapDimension;
        
        LWFCaveGenerator *generator = [[LWFCaveGenerator alloc]initWithHeight:mapDimension.numberTilesVertical width:mapDimension.numberTilesHorizontal];
        
        LWFCaveGeneratorResult *result = [generator generate];
        
        self.gridModel = result.stage;
        self.startingRoom = result.startingRoom;
        self.endingRoom = result.endingRoom;
        
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
                    SKTexture *texture = [self loadTextureForFloor];
                    texture.filteringMode = SKTextureFilteringNearest;
                    tile = [LWFTile spriteNodeWithTexture:texture];
                    [tile setWalkable:YES];
                } else if (cell.cellType == CaveCellTypeStart) {
                    SKTexture *texture = [SKTexture textureWithImageNamed:@"stairway_up"];
                    texture.filteringMode = SKTextureFilteringNearest;
                    tile = [LWFTile spriteNodeWithTexture:texture];
                    [tile setWalkable:NO];
                    self.startTile = tile;
                } else if (cell.cellType == CaveCellTypeEnd) {
                    SKTexture *texture = [SKTexture textureWithImageNamed:@"stairway_down"];
                    texture.filteringMode = SKTextureFilteringNearest;
                    tile = [LWFEndTile spriteNodeWithTexture:texture];
                    [tile setWalkable:NO];
                    self.endTile = tile;
                    
                } else if (cell.cellType == CaveCellTypeDoor) {
                    SKTexture *texture = [SKTexture textureWithImageNamed:@"door"];
                    texture.filteringMode = SKTextureFilteringNearest;
                    tile = [LWFTile spriteNodeWithTexture:texture];
                    [tile setWalkable:YES];
                    
                } else {
                    SKTexture *texture = [SKTexture textureWithImageNamed:@"wall"];
                    texture.filteringMode = SKTextureFilteringNearest;
                    tile = [LWFTile spriteNodeWithTexture:texture];
                    [tile setWalkable:NO];
                }
                
                tile.tileMap = self;
                tile.cellType = cell.cellType;
                tile.size = mapDimension.tileSize;
                tile.position = CGPointMake(x * mapDimension.tileSize.height, y * mapDimension.tileSize.height);
                tile.x = x;
                tile.y = y;
                tile.alpha = 0.0;
            
                self.tiles[x][y] = tile;
            }
        }
    }
    return self;
}

- (SKTexture *)loadTextureForFloor {
    SKTexture *texture = [SKTexture textureWithImageNamed:@"rock_tile"];
    
    LWFRandomUtils *randomUtils = [[LWFRandomUtils alloc]init];
    NSInteger randomInt = [randomUtils randomIntegerBetween:1 and:100];
    
    if (randomInt <= 5) {
        texture = [SKTexture textureWithImageNamed:@"grass_tile"];
    }
    randomInt = [randomUtils randomIntegerBetween:1 and:100];
    
    if (randomInt <= 5) {
        texture = [SKTexture textureWithImageNamed:@"water_tile"];
    }
    
    return texture;
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

- (LWFTile *)randomEmptyWalkableTileNotInStartAndEnd {
    while(1) {
        LWFTile *tile = [self randomEmptyWalkableTile];
        CGPoint tilePoint = CGPointMake(tile.x, tile.y);
        
        CGRect startRect = [self.startingRoom convert];
        CGRect endRect = [self.endingRoom convert];
        
        BOOL isInStart = CGRectContainsPoint(startRect, tilePoint);
        BOOL isInEnd = CGRectContainsPoint(endRect, tilePoint);
        
        if (!isInStart && !isInEnd) {
            return tile;
        }
    }
}

- (LWFTile *)randomEmptyWalkableTileNotInStartAndEndWithWalkableAdjacents:(NSInteger)numberOfAdjacentsRequired {
    while(1) {
        LWFTile *tile = [self randomEmptyWalkableTileNotInStartAndEnd];
        if (tile.cellType != CaveCellTypeFloor) {
            continue;
        }
        
        NSArray *neighbors = [self neighborsForTile:tile];
        
        NSInteger numberOfAdjacents = 0;
        
        for (LWFTile *neighborTile in neighbors) {
            if (neighborTile.cellType == CaveCellTypeFloor) {
                numberOfAdjacents++;
                
                if (numberOfAdjacents >= numberOfAdjacentsRequired) {
                    return tile;
                }
            }
        }
    }
}

- (BOOL)tile:(LWFTile *)possibleAdjacent isAdjacentTo:(LWFTile *)target {
    NSArray *adjacentsToTile = [self neighborsForTile:target];
    
    for (LWFTile *tile in adjacentsToTile) {
        if (tile.x == possibleAdjacent.x && tile.y == possibleAdjacent.y) {
            return YES;
        }
    }
    
    return NO;
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
