//
//  LWFCreature.h
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "LWFMoveable.h"
#import "LWFAttackable.h"
#import "LWFKillable.h"
#import "LWFLootable.h"
#import "LWFOTEObserver.h"
#import "LWFSoundEmitter.h"

@class LWFTile;
@class LWFMap;
@class LWFTurnList;
@class LWFPlayer;
@class LWFMelee;
@class LWFStats;
@class LWFEquips;

@class LWFTextDisplayQueue;

@class LWFMovementManager;
@class LWFAttackManager;
@class LWFOTEQueue;

@interface LWFCreature : SKSpriteNode <LWFMoveable, LWFAttackable, LWFKillable, LWFLootable, LWFOTEObserver, LWFSoundEmitter>

@property (nonatomic, strong) LWFMovementManager *movementManager;
@property (nonatomic, strong) LWFAttackManager *attackManager;
@property (nonatomic, strong) LWFOTEQueue *oteQueue;

@property (nonatomic, strong) LWFTile *currentTile;
@property (nonatomic, strong) LWFMap *map;
@property (nonatomic, strong) LWFTurnList *turnList;
@property (nonatomic, strong) NSMutableArray *tilePath;
@property (nonatomic, strong) LWFPlayer *player;

@property (nonatomic, strong) NSMutableArray *attacks;

@property (nonatomic, copy) NSString *spriteImageName;
@property (nonatomic, copy) NSString *currentFacingDirection;

@property (nonatomic, strong) LWFStats *stats;
@property (nonatomic, strong) LWFEquips *equips;

@property (nonatomic, strong) LWFCreature *nextCreature;

@property (nonatomic, strong) NSArray *lootChances;

@property (nonatomic, strong) LWFTextDisplayQueue *textDisplayQueue;

- (void)build;

- (void)processTurn;
- (void)turnBegun;
- (void)finishTurn;
- (void)processAIBehavior;

- (BOOL)isSurrounded;
- (void)buildPathToTile:(LWFTile *)tile;
- (void)walkToExistingPath;
- (void)startStandingAnimation;
- (BOOL)isInTheMeleeRangeTheCreature:(LWFCreature *)creature;
- (LWFMelee *)getMelee;
- (BOOL)isDead;
- (BOOL)isAlive;
- (void)receveidDamageLog:(NSInteger)damage fromCreature:(LWFCreature *)creature;
- (void)light;
- (void)dark;

@end
