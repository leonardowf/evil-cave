//
//  LWFMap.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFMap.h"

#import "LWFMapDimension.h"
#import "LWFTileMap.h"
#import "LWFTile.h"
#import "LWFPlayer.h"

@implementation LWFMap

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension
{
    self = [super init];
    if (self) {
        _mapDimension = mapDimension;
        _tileMap = [[LWFTileMap alloc]initWithMapDimension:mapDimension];
        
    }
    return self;
}

- (void)addTiles {
    for (NSInteger i = 0; i < self.mapDimension.numberTilesVertical; i++) {
        for (NSInteger j = 0; j < self.mapDimension.numberTilesHorizontal; j++) {
            LWFTile *tile = [self.tileMap tileForVertical:i andHorizontal:j];
            
            [self addChild:(SKSpriteNode *)tile];
        }
    }
}

- (LWFTile *)tileForPoint:(CGPoint)point {
    CGFloat rowPoint = point.y / self.mapDimension.tileSize.height;
    CGFloat columnPoint = point.x / self.mapDimension.tileSize.width;
    
    NSInteger row = (rowPoint + 0.5);
    NSInteger column = (columnPoint + 0.5);
    
    if (column < 0 || row < 0 || column >= self.mapDimension.numberTilesHorizontal || row >= self.mapDimension.numberTilesVertical) {
        return nil;
    }
    
    LWFTile *tile = [self.tileMap tileForVertical:row andHorizontal:column];
    
    return tile;
}

- (void)userTouchedPoint:(CGPoint)point {
    LWFTile *tile = [self tileForPoint:point];
    
    if (tile != nil) {
        [self.player moveToTile:tile];
    }
    
}

@end
