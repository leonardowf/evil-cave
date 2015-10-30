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

- (BOOL)canRaiseSkill:(LWFSkillType)skillType;
- (BOOL)canRaiseSkill:(LWFSkillType)skillType withTotalMoney:(NSInteger)money;

- (void)raiseSkill:(LWFSkillType)skillType;

- (NSInteger)bonusForSkillType:(LWFSkillType)skillType;
- (NSInteger)nextBonusForSkillType:(LWFSkillType)skillType;
- (NSInteger)currentLevelForSkillType:(LWFSkillType)skillType;
- (NSInteger)maximumSkillLevel:(LWFSkillType)skillType;
- (NSInteger)nextPriceForSkillType:(LWFSkillType)skillType;

- (NSString *)nameForSkill:(LWFSkillType)skillType;
- (NSString *)descriptionForSkill:(LWFSkillType)skillType;

@end
