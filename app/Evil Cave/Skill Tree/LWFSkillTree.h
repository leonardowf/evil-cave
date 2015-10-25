//
//  LWFSkillTree.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/12/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LWFSkillTypeHPPlus,
    LWFSkillTypeStrengthPlus,
    LWFSkillTypeSpinningAttackLevelUp,
    LWFSkillTypeLootPlus,
    LWFSkillTypePotionEffectUp,
    LWFSkillTypeArmorUp,
    LWFSkillTypeCount
} LWFSkillType;

@interface LWFSkillTree : NSObject

+ (id)sharedSkillTree;

@property (nonatomic) NSInteger HPLevel;
@property (nonatomic) NSInteger strengthLevel;
@property (nonatomic) NSInteger spinningAttackLevel;
@property (nonatomic) NSInteger lootLevel;
@property (nonatomic) NSInteger potionLevel;
@property (nonatomic) NSInteger armorLevel;

- (NSInteger)nextHPPrice;
- (NSInteger)nextStrengthPrice;
- (NSInteger)nextSpinningAttackPrice;
- (NSInteger)nextLootPrice;
- (NSInteger)nextPotionPrice;
- (NSInteger)nextArmorPrice;

- (BOOL)canRaiseSkill:(LWFSkillType)skillType;
- (void)raiseSkill:(LWFSkillType)skillType;
- (NSInteger)bonusForSkillType:(LWFSkillType)skillType;
- (NSInteger)nextBonusForSkillType:(LWFSkillType)skillType;
- (NSInteger)currentLevelForSkillType:(LWFSkillType)skillType;

@end
