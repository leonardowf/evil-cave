//
//  LWFStats.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFStats.h"

@implementation LWFStats

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSNumber *maxHP = [dictionary objectForKey:@"max_hp"];
        NSNumber *actionPoints = [dictionary objectForKey:@"action_points"];
        NSNumber *strength = [dictionary objectForKey:@"strength"];
        NSNumber *chanceToHit = [dictionary objectForKey:@"chance_to_hit"];
        NSNumber *baseArmor = [dictionary objectForKey:@"base_armor"];
        
        self.maxHP = [maxHP unsignedIntegerValue];
        self.actionPoints = [actionPoints unsignedIntegerValue];
        self.strength = [strength unsignedIntegerValue];
        self.chanceToHit = [chanceToHit unsignedIntegerValue];
        self.baseArmor = [baseArmor unsignedIntegerValue];
    }
    return self;
}

@end
