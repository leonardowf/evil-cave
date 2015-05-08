//
//  LWFItemComparison.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/15/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemComparison.h"
#import "LWFEquipment.h"

@implementation LWFItemComparison

+ (LWFItemComparison *)compare:(LWFEquipment *)equipment1 withEquipment:(LWFEquipment *)equipment2 {
    LWFItemComparison *result = [[LWFItemComparison alloc]init];
    
    result.strength = [equipment1.strength integerValue] - [equipment2.strength integerValue];
    result.hp = [equipment1.HP integerValue] - [equipment2.HP integerValue];
    result.minimumDamage = [equipment1.lowdamage integerValue] - [equipment2.lowdamage integerValue];
    result.maximumDamage = [equipment1.highdamage integerValue] - [equipment2.highdamage integerValue];
    
    return result;
}

@end
