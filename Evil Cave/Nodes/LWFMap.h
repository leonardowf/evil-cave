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
@class LWFPlayer;

@interface LWFMap : SKNode

@property (nonatomic, readonly, strong) LWFMapDimension *mapDimension;
@property (nonatomic, readonly, strong) LWFTileMap *tileMap;
@property (nonatomic, strong) LWFPlayer *player;

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension;
- (void)addTiles;
- (LWFTile *)tileForPoint:(CGPoint)point;
- (void)userTouchedPoint:(CGPoint)point;

@end
