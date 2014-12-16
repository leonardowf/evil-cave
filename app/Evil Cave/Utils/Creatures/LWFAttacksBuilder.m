//
//  LWFAttacksBuilder.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttacksBuilder.h"
#import "LWFMelee.h"

@implementation LWFAttacksBuilder

- (NSMutableArray *)attacksForCreatureType:(LWFCreatureType)creatureType {
    NSMutableArray *attacks = nil;
    
    if (creatureType == LWFCreatureTypeRat) {
        return [self ratAttacks];
    } else if (creatureType == LWFCreatureTypeGoblin) {
        return [self goblinAttacks];
    } else if (creatureType == LWFCreatureTypeRadioactiveRat) {
        return [self radioactiveRatAttacks];
    }
    
    return attacks;
}

- (NSMutableArray *)ratAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

- (NSMutableArray *)radioactiveRatAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

- (NSMutableArray *)goblinAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

@end
