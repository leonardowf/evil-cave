
//
//  LWFProgressionFunctionFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/15/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFProgressionFunctionFactory.h"

#import "LWFProgressionFunction.h"
#import "LWFPriceFunctionHpPlus.h"

@implementation LWFProgressionFunctionFactory

- (LWFProgressionFunction *)priceFunctionForSkillType:(LWFSkillType)skillType {
    if (skillType == LWFSkillTypeHPPlus) {
        return [LWFPriceFunctionHpPlus new];
    }
    
    return nil;
}

- (LWFProgressionFunction *)statGrowthFunctionForSkillType:(LWFSkillType)skillType {
    return nil;
}

@end
