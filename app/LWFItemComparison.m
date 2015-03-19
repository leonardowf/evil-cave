//
//  LWFItemComparison.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/15/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemComparison.h"
#import "LWFItem.h"

@implementation LWFItemComparison

+ (LWFItemComparison *)compare:(LWFItem *)item1 withItem:(LWFItem *)item2 {
    LWFItemComparison *result = [[LWFItemComparison alloc]init];
    
    result.strength = [item1.strength integerValue] - [item2.strength integerValue];
    result.hp = [item1.HP integerValue] - [item2.HP integerValue];
    result.minimumDamage = [item1.lowdamage integerValue] - [item2.lowdamage integerValue];
    result.maximumDamage = [item1.highdamage integerValue] - [item2.highdamage integerValue];
    
    return result;
}

@end
