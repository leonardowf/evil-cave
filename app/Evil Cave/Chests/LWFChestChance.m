//
//  LWFChestChance.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFChestChance.h"
#import "LWFRandomUtils.h"
#import "LWFLootChance.h"
#import "LWFItemPrototypeFactory.h"

@implementation LWFChestChance

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSNumber *quantityNumber = [dictionary objectForKey:@"quantity"];
        NSNumber *floorNumber = [dictionary objectForKey:@"floor"];
        NSNumber *chanceNumber = [dictionary objectForKey:@"chance"];
        
        self.quantity = [quantityNumber integerValue];
        self.floor = [floorNumber integerValue];
        self.chance = [chanceNumber floatValue];
        
        NSMutableArray *lootChances = [[NSMutableArray alloc]init];
        NSArray *lootChancesJson = [dictionary objectForKey:@"loot_chances"];
        for (NSDictionary *lootChancesDict in lootChancesJson) {
            LWFLootChance *lootChance = [[LWFLootChance alloc]
                                         initWithDictionary:lootChancesDict];
            [lootChances addObject:lootChance];
            
        }
        self.lootChances = lootChances;
    }
    return self;
}

- (NSInteger)amountRespawned {
    NSInteger amountRespawned = 0;
    LWFRandomUtils *randomUtils = [[LWFRandomUtils alloc]init];
    
    for (NSInteger i = 0; i < self.quantity; i++) {
        CGFloat randomized = [randomUtils randomFloatBetween:0.0 and:100.0];
        
        if (randomized <= self.chance) {
            amountRespawned++;
        }
    }
    
    return amountRespawned;
}

@end
