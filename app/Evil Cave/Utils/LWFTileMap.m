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

@implementation LWFTileMap

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension
{
    self = [super init];
    if (self) {
        
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
                }
                else if (cell.cellType == CaveCellTypeFloor) {
                   tile = [[LWFTile alloc]initWithColor:[UIColor brownColor] size:mapDimension.tileSize];
                } else {
                    tile = [[LWFTile alloc]initWithColor:[UIColor blackColor] size:mapDimension.tileSize];
                }
                
                tile.position = CGPointMake(j * mapDimension.tileSize.height, i * mapDimension.tileSize.height);
                
                self.tiles[i][j] = tile;
            }
        }
    }
    return self;
}

- (LWFTile *)tileForVertical:(NSInteger)vertical andHorizontal:(NSInteger)horizontal {
    LWFTile *result;
    
    result = self.tiles[vertical][horizontal];
    
    return result;
}

@end
