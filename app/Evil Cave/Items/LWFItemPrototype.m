//
//  LWFItemPrototype.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemPrototype.h"

@implementation LWFItemPrototype

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.baseDamage = [self dict:dict integerForKey:@"base_dmg"];
        self.minDamage = [self dict:dict integerForKey:@"min_dmg"];
        self.maxDamage = [self dict:dict integerForKey:@"max_dmg"];
        self.baseStrength = [self dict:dict integerForKey:@"base_str"];
        self.minStrength = [self dict:dict integerForKey:@"min_str"];
        self.maxStrength = [self dict:dict integerForKey:@"max_str"];
        self.baseHP = [self dict:dict integerForKey:@"base_hp"];
        self.maxHP = [self dict:dict integerForKey:@"max_hp"];
        self.minHP = [self dict:dict integerForKey:@"min_hp"];
        self.baseArmor = [self dict:dict integerForKey:@"base_armor"];
        self.minArmor = [self dict:dict integerForKey:@"min_armor"];
        self.maxArmor = [self dict:dict integerForKey:@"max_armor"];
    }
    return self;
}

- (NSNumber *)dict:(NSDictionary *)dict integerForKey:(NSString *)key {
    NSString *object = [dict objectForKey:key];
    
    if (object == nil) return nil;
    
    return [NSNumber numberWithInteger:[object integerValue]];
}

@end
