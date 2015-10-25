//
//  LWFSkillTree.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/12/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillTree.h"

#import "LWFProgressionFunctionFactory.h"
#import "LWFProgressionFunction.h"

@interface LWFSkillTree () {
    LWFProgressionFunctionFactory *_factory;
    NSArray *_maximumLevel;
}
@end

@implementation LWFSkillTree

SINGLETON_FOR_CLASS(SkillTree)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _factory = [LWFProgressionFunctionFactory new];
        _maximumLevel = [self loadMaximumLevel];
    }
    return self;
}

- (NSArray *)loadMaximumLevel {
    NSMutableArray *maximumLevel = [NSMutableArray arrayWithCapacity:LWFSkillTypeCount];
    
    maximumLevel[LWFSkillTypeHPPlus] = @1;
    maximumLevel[LWFSkillTypeStrengthPlus] = @2;
    maximumLevel[LWFSkillTypeSpinningAttackLevelUp] = @3;
    maximumLevel[LWFSkillTypeLootPlus] = @4;
    maximumLevel[LWFSkillTypePotionEffectUp] = @5;
    maximumLevel[LWFSkillTypeArmorUp] = @6;
    
    return maximumLevel;
}

- (NSInteger)nextPriceForSkill:(LWFSkillType)skillType atCurrentLevel:(NSInteger)currentLevel {
    NSInteger newLevel = currentLevel + 1;
    LWFProgressionFunction *progressFunction = [_factory priceFunctionForSkillType:skillType];
    
    return [progressFunction calculateForInput:newLevel];
}

- (NSInteger)nextHPPrice {
    return [self nextPriceForSkill:LWFSkillTypeHPPlus atCurrentLevel:self.HPLevel];
}

- (NSInteger)nextStrengthPrice {
    return [self nextPriceForSkill:LWFSkillTypeStrengthPlus atCurrentLevel:self.strengthLevel + 1];
}

- (NSInteger)nextSpinningAttackPrice {
    return [self nextPriceForSkill:LWFSkillTypeSpinningAttackLevelUp atCurrentLevel:self.spinningAttackLevel + 1];
}

- (NSInteger)nextLootPrice {
    return [self nextPriceForSkill:LWFSkillTypeLootPlus atCurrentLevel:self.lootLevel + 1];
}

- (NSInteger)nextPotionPrice {
    return [self nextPriceForSkill:LWFSkillTypePotionEffectUp atCurrentLevel:self.potionLevel + 1];
}

- (NSInteger)nextArmorPrice {
    return [self nextPriceForSkill:LWFSkillTypeArmorUp atCurrentLevel:self.armorLevel + 1];
}

- (BOOL)canRaiseSkill:(LWFSkillType)skillType {
    
    NSNumber *maximumLevelNumber = _maximumLevel[skillType];
    NSInteger maximumLevel = [maximumLevelNumber integerValue];
    NSInteger currentLevel = [self currentLevelForSkillType:skillType];
    if (currentLevel >= maximumLevel) {
        return NO;
    }
    
    return YES;
}

- (NSInteger)maximumSkillLevel:(LWFSkillType)skillType {
    NSNumber *maximumLevelNumber = _maximumLevel[skillType];
    NSInteger maximumLevel = [maximumLevelNumber integerValue];
    
    return maximumLevel;
}

- (NSInteger)bonusForSkillType:(LWFSkillType)skillType {
    NSInteger currentLevel = [self currentLevelForSkillType:skillType];
    
    LWFProgressionFunction *growthFunction = [_factory statGrowthFunctionForSkillType:skillType];
    
    return [growthFunction calculateForInput:currentLevel];
}

- (NSInteger)nextBonusForSkillType:(LWFSkillType)skillType {
    NSInteger currentLevel = [self currentLevelForSkillType:skillType] + 1;
    
    LWFProgressionFunction *growthFunction = [_factory statGrowthFunctionForSkillType:skillType];
    
    return [growthFunction calculateForInput:currentLevel];
}

- (NSInteger)currentLevelForSkillType:(LWFSkillType)skillType {
    switch (skillType) {
        case LWFSkillTypeArmorUp:
            return self.armorLevel;
        case LWFSkillTypePotionEffectUp:
            return self.potionLevel;
        case LWFSkillTypeLootPlus:
            return self.lootLevel;
        case LWFSkillTypeSpinningAttackLevelUp:
            return self.spinningAttackLevel;
        case LWFSkillTypeStrengthPlus:
            return self.strengthLevel;
        case LWFSkillTypeHPPlus:
            return self.HPLevel;
        case LWFSkillTypeCount:
            NSLog(@"noop");
    }
    assert(!"Skill Type deve existir.");
}

- (void)raiseSkill:(LWFSkillType)skillType {
    if (![self canRaiseSkill:skillType]) {
        return;
    }
    
    switch (skillType) {
        case LWFSkillTypeArmorUp:
            self.armorLevel++;
            break;
        case LWFSkillTypePotionEffectUp:
            self.potionLevel++;
            break;
        case LWFSkillTypeLootPlus:
            self.lootLevel++;
            break;
        case LWFSkillTypeSpinningAttackLevelUp:
            self.spinningAttackLevel++;
            break;
        case LWFSkillTypeStrengthPlus:
            self.strengthLevel++;
            break;
        case LWFSkillTypeHPPlus:
            self.HPLevel++;
            break;
        case LWFSkillTypeCount:
            NSLog(@"noop");
    }
}

@end