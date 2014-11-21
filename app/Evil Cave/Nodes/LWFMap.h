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
@class LWFMovementManager;

@interface LWFMap : SKNode

@property (nonatomic, readonly, strong) LWFMapDimension *mapDimension;
@property (nonatomic, readonly, strong) LWFTileMap *tileMap;
@property (nonatomic, strong) LWFPlayer *player;
@property (nonatomic, strong) LWFMovementManager *movementManager;

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension;
- (void)addTiles;
- (void)addPlayer:(LWFPlayer *)player;
- (LWFTile *)tileForPoint:(CGPoint)point;
- (void)userTouchedPoint:(CGPoint)point;

- (void)playerMoved;

@end
