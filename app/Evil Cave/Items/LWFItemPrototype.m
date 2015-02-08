//
//  LWFItemPrototype.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemPrototype.h"
#import "LWFItem.h"

@implementation LWFItemPrototype

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.imageName = [dict objectForKey:@"image_name"];
        self.identifier = [dict objectForKey:@"identifier"];
        self.category = [dict objectForKey:@"category"];
        
        self.baseLowdamage = [self dict:dict integerForKey:@"base_lowdamage"];
        self.minLowdamage = [self dict:dict integerForKey:@"min_lowdamage"];
        self.maxLowdamage = [self dict:dict integerForKey:@"max_lowdamage"];
        
        self.baseHighdamage = [self dict:dict integerForKey:@"base_highdamage"];
        self.minHighdamage = [self dict:dict integerForKey:@"min_highdamage"];
        self.maxHighdamage = [self dict:dict integerForKey:@"max_highdamage"];
        
        self.baseStrength = [self dict:dict integerForKey:@"base_str"];
        self.minStrength = [self dict:dict integerForKey:@"min_str"];
        self.maxStrength = [self dict:dict integerForKey:@"max_str"];
        self.baseHp = [self dict:dict integerForKey:@"base_hp"];
        self.maxHp = [self dict:dict integerForKey:@"max_hp"];
        self.minHp = [self dict:dict integerForKey:@"min_hp"];
        self.baseArmor = [self dict:dict integerForKey:@"base_armor"];
        self.minArmor = [self dict:dict integerForKey:@"min_armor"];
        self.maxArmor = [self dict:dict integerForKey:@"max_armor"];
        
        self.atlas = [dict objectForKey:@"atlas"];
    }
    return self;
}

- (NSNumber *)dict:(NSDictionary *)dict integerForKey:(NSString *)key {
    NSString *object = [dict objectForKey:key];
    
    if (object == nil) return nil;
    
    return [NSNumber numberWithInteger:[object integerValue]];
}

- (LWFItem *)build {
    return [[LWFItem alloc]initWithItemPrototype:self];
}

@end
