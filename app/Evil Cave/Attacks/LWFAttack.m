//
//  LWFAttack.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttack.h"
#import "LWFPointObject.h"
#import "LWFTile.h"
#import "LWFPointObject.h"
#import "LWFTileMap.h"

@implementation LWFAttack

- (NSMutableArray *)tilesInRangeForTile:(LWFTile *)tile withTileMap:(LWFTileMap *)tileMap {
    NSMutableArray *range = [self range];
    NSMutableArray *tiles = [NSMutableArray array];
    
    for (LWFPointObject *point in range) {
        LWFTile *possibleTile;
        
        NSInteger x = tile.x + point.x;
        NSInteger y = tile.y + point.y;
        
        if ([tileMap isInBoundsTheTileWithX:x andY:y]) {
            possibleTile = [tileMap tileForVertical:y andHorizontal:x];
            
            if ([possibleTile isWalkable]) {
                [tiles addObject:possibleTile];
            }
        }
    }
    
    return tiles;
}

- (NSMutableArray *)range {
    return nil;
}

@end
