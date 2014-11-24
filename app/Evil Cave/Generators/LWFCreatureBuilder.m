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

@implementation LWFCreatureBuilder

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType {
    LWFCreature *creature;
    
    if (creatureType == LWFCreatureTypeRat) {
        creature = [[LWFRat alloc]init];
    } else if (creatureType == LWFCreatureTypeGoblin) {
        creature = [[LWFGoblin alloc]init];
    }
    
    
    if (creature != nil) {
        [creature build];
    }
    
    return creature;
}

@end
