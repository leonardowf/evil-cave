//
//  LWFCreatureBuilder.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/23/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWFCreature;

typedef enum : NSUInteger {
    LWFCreatureTypePlayer,
    LWFCreatureTypeRat,
    LWFCreatureTypeSpider,
    LWFCreatureTypeGoblin
} LWFCreatureType;

@interface LWFCreatureBuilder : NSObject

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType;

@end
