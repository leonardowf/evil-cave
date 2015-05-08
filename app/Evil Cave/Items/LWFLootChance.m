//
//  LWFLootChance.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLootChance.h"
#import "LWFRandomUtils.h"
#import "LWFItemPrototype.h"
#import "LWFItemFactory.h"
#import "LWFNewItem.h"

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

- (LWFNewItem *)buildWithQuantity:(NSInteger)quantity {
    LWFItemFactory *itemFactory = [LWFItemFactory new];
    
    if (quantity == 0) {
        return nil;
    }
    
    LWFNewItem *item = [itemFactory manufactureWithItemPrototype:self.prototype];
    item.quantity = quantity;
    
    return item;
}

@end
