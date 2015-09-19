//
//  LWFCreatureBuilder.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/23/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWFCreature;
@class LWFMovementManager;
@class LWFAttackManager;
@class LWFMapDimension;
@class LWFMap;
@class LWFTurnList;

typedef enum : NSUInteger {
    LWFCreatureTypeWarrior,
    LWFCreatureTypeRat,
    LWFCreatureTypePoopThrowerRat,
    LWFCreatureTypeSpider,
    LWFCreatureTypeGoblin,
    LWFCreatureTypeRadioactiveRat,
    LWFCreatureTypeRatKing
} LWFCreatureType;

@interface LWFCreatureBuilder : NSObject

- (instancetype)initWithMap:(LWFMap *)map movementManager:(LWFMovementManager *)movementManager andMapDimension:(LWFMapDimension *)mapDimension andTurnList:(LWFTurnList *)turnList andAttackManager:(LWFAttackManager *)attackManager;
- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType;
- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType andSize:(CGSize)size;

@end
