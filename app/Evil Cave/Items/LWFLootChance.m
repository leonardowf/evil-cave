//
//  LWFLootChance.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLootChance.h"

@implementation LWFLootChance

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        NSString *nameString = [dict objectForKey:@"name"];
        NSNumber *quantityNumber = [dict objectForKey:@"quantity"];
        NSNumber *chanceNumber = [dict objectForKey:@"chance"];
        
        self.name = nameString;
        self.quantity = [quantityNumber integerValue];
        self.chance = [chanceNumber floatValue];
    }
    return self;
}

@end
