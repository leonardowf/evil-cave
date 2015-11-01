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
#import "NSDictionary+PrimitiveHelpers.h"
#import "LWFDictionaryConverter.h"
#import "LWFRepository.h"
#import "LWFUserDefaultsPersistenceStrategy.h"

@interface LWFSkillTree () {
    LWFProgressionFunctionFactory *_factory;
    NSArray *_maximumLevel;
    LWFRepository *_repository;
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
        
        LWFUserDefaultsPersistenceStrategy *persistanceStrategy = [[LWFUserDefaultsPersistenceStrategy alloc]init];
        _repository = [[LWFRepository alloc]initWithPersistenceStrategy:persistanceStrategy];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}

- (void)loadFromDictionary:(NSDictionary *)dictionary {
    self.HPLevel = [dictionary integerForKey:@"HPLevel"];
    self.strengthLevel = [dictionary integerForKey:@"strengthLevel"];
    self.spinningAttackLevel = [dictionary integerForKey:@"spinningAttackLevel"];
    self.lootLevel = [dictionary integerForKey:@"lootLevel"];
    self.potionLevel = [dictionary integerForKey:@"potionLevel"];
    self.armorLevel = [dictionary integerForKey:@"armorLevel"];
}

- (NSArray *)loadMaximumLevel {
    NSMutableArray *maximumLevel = [NSMutableArray arrayWithCapacity:LWFSkillTypeCount];
    
    maximumLevel[LWFSkillTypeHPPlus] = @40;
    maximumLevel[LWFSkillTypeStrengthPlus] = @40;
    maximumLevel[LWFSkillTypeSpinningAttackLevelUp] = @20;
    maximumLevel[LWFSkillTypeLootPlus] = @40;
    maximumLevel[LWFSkillTypePotionEffectUp] = @10;
    maximumLevel[LWFSkillTypeArmorUp] = @20;
    
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
    
    [_repository saveSkillTree:self];
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

- (void)clear {
    NSDictionary *dictionary = [self toDictionary];
    NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    
    for (NSString* key in mutable.allKeys) {
        mutable[key] = @0;
    }
    
    [self loadFromDictionary:mutable];
    
    [_repository saveSkillTree:self];
}

@end