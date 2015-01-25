//
//  LWFLootChance.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLootChance.h"
#import "LWFRandomUtils.h"
#import "LWFItem.h"
#import "LWFItemPrototype.h"

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

- (NSInteger)amountDropped {
    LWFRandomUtils *randomUtils = [[LWFRandomUtils alloc]init];
    float randomFloat = [randomUtils randomFloatBetween:0.0 and:100.0];
    if (randomFloat > self.chance) {
        return 0;
    }
    
    NSInteger randomQuantity = [randomUtils randomIntegerBetween:1 and:self.quantity];
    
    return randomQuantity;
}

- (LWFItem *)buildWithQuantity:(NSInteger)quantity {
    if (quantity == 0) {
        return nil;
    }
    
    LWFItem *item = [self.prototype build];
    item.quantity = quantity;
    
    return item;
}

@end
