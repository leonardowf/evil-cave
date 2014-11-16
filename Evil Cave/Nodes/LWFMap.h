//
//  LWFMap.h
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class LWFMapDimension;
@class LWFTileMap;
@class LWFTile;

@interface LWFMap : SKNode

@property (nonatomic, readonly, strong) LWFMapDimension *mapDimension;
@property (nonatomic, readonly, strong) LWFTileMap *tileMap;

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension;
- (void)addTiles;
- (LWFTile *)tileForPoint:(CGPoint)point;

@end
