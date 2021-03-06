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
#import "LWFItem.h"
#import "LWFItemPrototypeFactory.h"

@implementation LWFLootChance

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        LWFItemPrototypeFactory *itemPrototypeFactory = [LWFItemPrototypeFactory
                                                         sharedItemPrototypeFactory];
        
        NSString *nameString = [dict objectForKey:@"name"];
        NSNumber *quantityNumber = [dict objectForKey:@"quantity"];
        NSNumber *chanceNumber = [dict objectForKey:@"chance"];
        
        self.name = nameString;
        self.quantity = [quantityNumber integerValue];
        self.chance = [chanceNumber floatValue];
        
        LWFItemPrototype *prototype = [itemPrototypeFactory getPrototypeWithName:self.name];
        self.prototype = prototype;
    }
    return self;
}

- (NSInteger)amountDropped {
    LWFRandomUtils *randomUtils = [[LWFRandomUtils alloc]init];
    float randomFloat = [randomUtils randomFloatBetween:0.0 and:100.0];
    
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    float lootBonusInPercent = [skillTree bonusForSkillType:LWFSkillTypeLootPlus];
    randomFloat = randomFloat - lootBonusInPercent;
    
    if (randomFloat > self.chance) {
        return 0;
    }
    
    NSInteger randomQuantity = [randomUtils randomIntegerBetween:1 and:self.quantity];
    
    return randomQuantity;
}

- (LWFItem *)buildWithQuantity:(NSInteger)quantity {
    LWFItemFactory *itemFactory = [LWFItemFactory new];
    
    if (quantity == 0) {
        return nil;
    }
    
    LWFItem *item = [itemFactory manufactureWithItemPrototype:self.prototype];
    item.quantity = quantity;
    
    return item;
}

@end
