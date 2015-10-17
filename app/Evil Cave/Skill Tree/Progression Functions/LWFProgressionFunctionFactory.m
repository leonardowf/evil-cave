
//
//  LWFProgressionFunctionFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/15/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFProgressionFunctionFactory.h"
#import "LWFProgressFunctionsUmbrellaHeader.h"

@implementation LWFProgressionFunctionFactory

- (LWFProgressionFunction *)priceFunctionForSkillType:(LWFSkillType)skillType {
    if (skillType == LWFSkillTypeHPPlus) {
        return [LWFPriceFunctionHpPlus new];
    }
    
    if (skillType == LWFSkillTypeStrengthPlus) {
        return [LWFPriceFunctionStrengthPlus new];
    }
    
    if (skillType == LWFSkillTypeSpinningAttackLevelUp) {
        return [LWFPriceFunctionSpinningAttack new];
    }
    
    if (skillType == LWFSkillTypeLootPlus) {
        return [LWFPriceFunctionLootPlus new];
    }
    
    if (skillType == LWFSkillTypePotionEffectUp) {
        return [LWFPriceFunctionPotionEffectUp new];
    }
    
    if (skillType == LWFSkillTypeArmorUp) {
        return [LWFPriceFunctionArmorUp new];
    }
    
    return nil;
}

- (LWFProgressionFunction *)statGrowthFunctionForSkillType:(LWFSkillType)skillType {
    return nil;
}

@end
