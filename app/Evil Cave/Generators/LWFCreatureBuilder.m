//
//  LWFCreatureBuilder.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/23/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCreatureBuilder.h"
#import "LWFCreature.h"

#import "LWFRat.h"
#import "LWFGoblin.h"
#import "LWFMapDimension.h"
#import "LWFTurnList.h"
#import "LWFMap.h"

@interface LWFCreatureBuilder () {
    LWFMovementManager *_movementManager;
    LWFMap *_map;
    LWFMapDimension *_mapDimension;
    LWFTurnList *_turnList;

}
@end
@implementation LWFCreatureBuilder

- (instancetype)initWithMap:(LWFMap *)map movementManager:(LWFMovementManager *)movementManager andMapDimension:(LWFMapDimension *)mapDimension andTurnList:(LWFTurnList *)turnList
{
    self = [super init];
    if (self) {
        _movementManager = movementManager;
        _map = map;
        _mapDimension = mapDimension;
        _turnList = turnList;
    }
    return self;
}

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType {
    LWFCreature *creature;
    
    if (creatureType == LWFCreatureTypeRat) {
        creature = [[LWFRat alloc]init];
    } else if (creatureType == LWFCreatureTypeGoblin) {
        creature = [[LWFGoblin alloc]init];
    }
    
    if (creature != nil) {
        [creature build];
        creature.map = _map;
        creature.movementManager = _movementManager;
        creature.turnList = _turnList;
        creature.size = _mapDimension.tileSize;
        creature.player = _map.player;
    }
    
    return creature;
}

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType andSize:(CGSize)size {
    LWFCreature *creature = [self buildWithType:creatureType];
    creature.size = size;
    return creature;
}

@end
