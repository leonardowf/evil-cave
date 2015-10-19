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
@class LWFAttackManager;
@class LWFItemRange;
@class LWFCreatureBuilder;

@interface LWFMap : SKNode

@property (nonatomic, strong) LWFMapDimension *mapDimension;
@property (nonatomic, strong) LWFTileMap *tileMap;
@property (nonatomic, strong) LWFPlayer *player;
@property (nonatomic, strong) LWFMovementManager *movementManager;
@property (nonatomic, strong) LWFAttackManager *attackManager;
@property (nonatomic, strong) LWFItemRange *currentItemRange;
@property (nonatomic, strong) LWFCreatureBuilder *creatureBuilder;
@property (nonatomic) NSInteger floor;

- (instancetype)initWithScreenSize:(CGSize)size andFloor:(NSInteger)floor;

- (void)build;
- (void)addTiles;
- (void)addPlayer:(LWFPlayer *)player;
- (LWFTile *)tileForPoint:(CGPoint)point;
- (void)userTouchedPoint:(CGPoint)point;

- (void)newTurnCycleStarted;
- (void)loadGame;

- (void)movementRequestIsInvalid;

- (void)unlockUserInteraction;
- (void)processTouchQueue;
- (void)moveCameraToTile:(LWFTile *)tile completion:(void(^)(void))someBlock;

- (void)blockUserInteraction;
- (void)unblockUserInteraction;
- (void)resetTouchQueue;

-(void)shake:(NSInteger)times;

@end
