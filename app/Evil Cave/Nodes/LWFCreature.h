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

@class LWFTile;
@class LWFMap;
@class LWFTurnList;
@class LWFPlayer;

@class LWFMovementManager;
@class LWFAttackManager;

@interface LWFCreature : SKSpriteNode <LWFMoveable, LWFAttackable>

@property (nonatomic, strong) LWFMovementManager *movementManager;
@property (nonatomic, strong) LWFAttackManager *attackManager;

@property (nonatomic, strong) LWFTile *currentTile;
@property (nonatomic, strong) LWFMap *map;
@property (nonatomic, strong) LWFTurnList *turnList;
@property (nonatomic, strong) NSMutableArray *tilePath;
@property (nonatomic, strong) LWFPlayer *player;

@property (nonatomic, strong) NSMutableArray *attacks;

@property (nonatomic, copy) NSString *spriteImageName;
@property (nonatomic, copy) NSString *currentFacingDirection;

@property (nonatomic) NSUInteger currentHP;
@property (nonatomic) NSUInteger currentActions;


- (void)build;
- (void)processTurn;
- (void)finishTurn;
- (BOOL)isSurrounded;
- (void)buildPathToTile:(LWFTile *)tile;
- (void)walkToExistingPath;
- (void)startStandingAnimation;

@end
