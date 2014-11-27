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
@class LWFMapDimension;
@class LWFMap;

typedef enum : NSUInteger {
    LWFCreatureTypePlayer,
    LWFCreatureTypeRat,
    LWFCreatureTypeSpider,
    LWFCreatureTypeGoblin
} LWFCreatureType;

@interface LWFCreatureBuilder : NSObject

- (instancetype)initWithMap:(LWFMap *)map movementManager:(LWFMovementManager *)movementManager andMapDimension:(LWFMapDimension *)mapDimension;
- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType;
- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType andSize:(CGSize)size;

@end
