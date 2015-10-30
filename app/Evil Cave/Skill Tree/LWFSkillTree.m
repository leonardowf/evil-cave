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
    
    maximumLevel[LWFSkillTypeHPPlus] = @99;
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

- (NSInteger)nextPriceForSkillType:(LWFSkillType)skillType {
    NSInteger currentLevel = [self currentLevelForSkillType:skillType];
    
    return [self nextPriceForSkill:skillType atCurrentLevel:currentLevel + 1];
}

- (BOOL)canRaiseSkill:(LWFSkillType)skillType withTotalMoney:(NSInteger)money {
    NSInteger nextPrice = [self nextPriceForSkillType:skillType];
    
    if (money >= nextPrice) {
        return [self canRaiseSkill:skillType];
    }
    
    return NO;
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

- (NSString *)nameForSkill:(LWFSkillType)skillType {
    NSMutableArray *skillNames = [NSMutableArray arrayWithCapacity:LWFSkillTypeCount];
    
    [skillNames insertObject:@"HP Level Up" atIndex:LWFSkillTypeHPPlus];
    [skillNames insertObject:@"Strength Level Up" atIndex:LWFSkillTypeStrengthPlus];
    [skillNames insertObject:@"Special Attack Level Up" atIndex:LWFSkillTypeSpinningAttackLevelUp];
    [skillNames insertObject:@"Loot Chance Level Up" atIndex:LWFSkillTypeLootPlus];
    [skillNames insertObject:@"Potion Effect Level Up" atIndex:LWFSkillTypePotionEffectUp];
    [skillNames insertObject:@"Armor Level Up" atIndex:LWFSkillTypeArmorUp];
    
    return [skillNames objectAtIndex:skillType];
}

- (NSString *)descriptionForSkill:(LWFSkillType)skillType {
    NSMutableArray *skillNames = [NSMutableArray arrayWithCapacity:LWFSkillTypeCount];
    
    [skillNames insertObject:@"HP Level Up" atIndex:LWFSkillTypeHPPlus];
    [skillNames insertObject:@"Strength Level Up" atIndex:LWFSkillTypeStrengthPlus];
    [skillNames insertObject:@"Special Attack Level Up" atIndex:LWFSkillTypeSpinningAttackLevelUp];
    [skillNames insertObject:@"Loot Chance Level Up" atIndex:LWFSkillTypeLootPlus];
    [skillNames insertObject:@"Potion Effect Level Up" atIndex:LWFSkillTypePotionEffectUp];
    [skillNames insertObject:@"Armor Level Up" atIndex:LWFSkillTypeArmorUp];
    
    return [skillNames objectAtIndex:skillType];
}

@end