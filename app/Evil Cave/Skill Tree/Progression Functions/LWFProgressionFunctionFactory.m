
//
//  LWFProgressionFunctionFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/15/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFProgressionFunctionFactory.h"
#import "LWFProgressFunctionsUmbrellaHeader.h"

@interface LWFProgressionFunctionFactory () {
    NSArray *_priceFunctionsProxy;
    NSArray *_growthFunctionsProxy;
    
}
@end

@implementation LWFProgressionFunctionFactory

- (instancetype)init
{
    self = [super init];
    if (self) {
        _priceFunctionsProxy = [self loadPriceFunctions];
        _growthFunctionsProxy = [self loadGrowthFunctions];
    }
    return self;
}

- (NSArray *)loadPriceFunctions {
    NSMutableArray *proxy = [NSMutableArray arrayWithCapacity:LWFSkillTypeCount];
    
    [proxy insertObject:[LWFPriceFunctionHpPlus new] atIndex:LWFSkillTypeHPPlus];
    [proxy insertObject:[LWFPriceFunctionStrengthPlus new] atIndex:LWFSkillTypeStrengthPlus];
    [proxy insertObject:[LWFPriceFunctionSpinningAttack new] atIndex:LWFSkillTypeSpinningAttackLevelUp];
    [proxy insertObject:[LWFPriceFunctionLootPlus new] atIndex:LWFSkillTypeLootPlus];
    [proxy insertObject:[LWFPriceFunctionPotionEffectUp new] atIndex:LWFSkillTypePotionEffectUp];
    [proxy insertObject:[LWFPriceFunctionArmorUp new] atIndex:LWFSkillTypeArmorUp];
    
    return proxy;
}

- (NSArray *)loadGrowthFunctions {
    NSMutableArray *proxy = [NSMutableArray arrayWithCapacity:LWFSkillTypeCount];
    
    [proxy insertObject:[LWFGrowthFunctionHpPlus new] atIndex:LWFSkillTypeHPPlus];
    [proxy insertObject:[LWFGrowthFunctionStrenghtPlus new] atIndex:LWFSkillTypeStrengthPlus];
    [proxy insertObject:[LWFGrowthFunctionSpinningAttack new] atIndex:LWFSkillTypeSpinningAttackLevelUp];
    [proxy insertObject:[LWFGrowthFunctionLootPlus new] atIndex:LWFSkillTypeLootPlus];
    [proxy insertObject:[LWFGrowthFunctionPotionEffectUp new] atIndex:LWFSkillTypePotionEffectUp];
    [proxy insertObject:[LWFGrowthFunctionArmorUp new] atIndex:LWFSkillTypeArmorUp];
    
    return proxy;
}


- (LWFProgressionFunction *)priceFunctionForSkillType:(LWFSkillType)skillType {
    return [_priceFunctionsProxy objectAtIndex:skillType];
}

- (LWFProgressionFunction *)statGrowthFunctionForSkillType:(LWFSkillType)skillType {
    return [_growthFunctionsProxy objectAtIndex:skillType];
}

@end