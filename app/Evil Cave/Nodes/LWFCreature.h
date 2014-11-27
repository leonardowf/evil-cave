//
//  LWFCreature.h
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LWFMoveable.h"

@class LWFTile;
@class LWFMap;
@class LWFTurnList;

@class LWFMovementManager;

@interface LWFCreature : SKSpriteNode <LWFMoveable>

@property (nonatomic, strong) LWFMovementManager *movementManager;
@property (nonatomic, strong) LWFTile *currentTile;
@property (nonatomic, strong) LWFMap *map;
@property (nonatomic, strong) LWFTurnList *turnList;
@property (nonatomic, strong) NSMutableArray *tilePath;

@property (nonatomic, copy) NSString *spriteImageName;

- (void)build;
- (void)processTurn;

@end
