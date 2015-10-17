
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
    NSArray *_proxy;
}
@end

@implementation LWFProgressionFunctionFactory

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *proxy = [NSMutableArray arrayWithCapacity:LWFSkillTypeCount];
        
        [proxy insertObject:[LWFPriceFunctionHpPlus new] atIndex:LWFSkillTypeHPPlus];
        [proxy insertObject:[LWFPriceFunctionStrengthPlus new] atIndex:LWFSkillTypeStrengthPlus];
        [proxy insertObject:[LWFPriceFunctionSpinningAttack new] atIndex:LWFSkillTypeSpinningAttackLevelUp];
        [proxy insertObject:[LWFPriceFunctionLootPlus new] atIndex:LWFSkillTypeLootPlus];
        [proxy insertObject:[LWFPriceFunctionPotionEffectUp new] atIndex:LWFSkillTypePotionEffectUp];
        [proxy insertObject:[LWFPriceFunctionArmorUp new] atIndex:LWFSkillTypeArmorUp];
        
        _proxy = proxy;
    }
    return self;
}


- (LWFProgressionFunction *)priceFunctionForSkillType:(LWFSkillType)skillType {
    return [_proxy objectAtIndex:skillType];
}

- (LWFProgressionFunction *)statGrowthFunctionForSkillType:(LWFSkillType)skillType {
    return nil;
}

@end