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
#import "LWFMovementManager.h"

@implementation LWFMap

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension
{
    self = [super init];
    if (self) {
        _mapDimension = mapDimension;
        _tileMap = [[LWFTileMap alloc]initWithMapDimension:mapDimension];
        _movementManager = [[LWFMovementManager alloc]initWithTileMap:_tileMap];
        
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
    CGPoint tileCoordinate = [self tileCoordinateForTouchPoint:point];
    
    NSInteger row = tileCoordinate.y;
    NSInteger column = tileCoordinate.x;
    
    if (column < 0 || row < 0 || column >= self.mapDimension.numberTilesHorizontal || row >= self.mapDimension.numberTilesVertical) {
        return nil;
    }
    
    LWFTile *tile = [self.tileMap tileForVertical:row andHorizontal:column];
    
    return tile;
}

- (CGPoint)tileCoordinateForTouchPoint:(CGPoint)touchPoint {
    CGFloat rowPoint = touchPoint.y / self.mapDimension.tileSize.height;
    CGFloat columnPoint = touchPoint.x / self.mapDimension.tileSize.width;
    
    NSInteger row = (rowPoint + 0.5);
    NSInteger column = (columnPoint + 0.5);
    
    return CGPointMake(column, row);
}

- (void)addPlayer:(LWFPlayer *)player {
    self.player = player;
    self.player.position = self.tileMap.startTile.position;
    
    [self addChild:self.player];
}


- (void)userTouchedPoint:(CGPoint)point {
    

    LWFTile *tile = [self tileForPoint:point];
    
    if (tile != nil) {
        CGPoint tileCoordinate = [self tileCoordinateForTouchPoint:point];
        [self.movementManager moveable:self.player requestMoveToTileAtX:tileCoordinate.x andY:tileCoordinate.y];
    }
}

@end
