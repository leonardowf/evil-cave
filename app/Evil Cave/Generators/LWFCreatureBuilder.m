//
//  LWFCreatureBuilder.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/23/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCreatureBuilder.h"
#import "LWFCreature.h"

#import "LWFPlayer.h"
#import "LWFRat.h"
#import "LWFGoblin.h"
#import "LWFRadioactiveRat.h"

#import "LWFMapDimension.h"
#import "LWFTurnList.h"
#import "LWFMap.h"
#import "LWFAttacksBuilder.h"

#import "LWFMelee.h"
#import "LWFGameController.h"

@interface LWFCreatureBuilder () {
    LWFMovementManager *_movementManager;
    LWFMap *_map;
    LWFMapDimension *_mapDimension;
    LWFTurnList *_turnList;
    LWFAttackManager *_attackManager;
    LWFAttacksBuilder *_attacksBuilder;
    

}
@end
@implementation LWFCreatureBuilder

- (instancetype)initWithMap:(LWFMap *)map movementManager:(LWFMovementManager *)movementManager andMapDimension:(LWFMapDimension *)mapDimension andTurnList:(LWFTurnList *)turnList andAttackManager:(LWFAttackManager *)attackManager
{
    self = [super init];
    if (self) {
        LWFGameController *gameController = [LWFGameController sharedGameController];
        
        _movementManager = movementManager;
        _map = map;
        _mapDimension = mapDimension;
        _turnList = turnList;
        _attackManager = attackManager;
        _attacksBuilder = [[LWFAttacksBuilder alloc]init];
        
        gameController.tileMap = map.tileMap;

    }
    return self;
}

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType {
    LWFCreature *creature;
    
    if (creatureType == LWFCreatureTypeRat) {
        creature = [[LWFRat alloc]init];
    } else if (creatureType == LWFCreatureTypeGoblin) {
        creature = [[LWFGoblin alloc]init];
    } else if (creatureType == LWFCreatureTypeRadioactiveRat) {
        creature = [[LWFRadioactiveRat alloc]init];
    } else if (creatureType == LWFCreatureTypeWarrior) {
        creature = [[LWFPlayer alloc]init];
        creature.spriteImageName = @"warrior";
    }
    
    if (creature != nil) {
        [creature build];
        creature.map = _map;
        creature.movementManager = _movementManager;
        creature.attackManager = _attackManager;
        creature.turnList = _turnList;
        creature.size = _mapDimension.tileSize;
        creature.player = _map.player;
        creature.attacks = [_attacksBuilder attacksForCreatureType:creatureType];
    }
    
    return creature;
}

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType andSize:(CGSize)size {
    LWFCreature *creature = [self buildWithType:creatureType];
    creature.size = size;
    return creature;
}

@end
