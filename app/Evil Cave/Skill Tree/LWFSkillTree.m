//
//  LWFSkillTree.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/12/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillTree.h"

typedef enum : NSUInteger {
    LWFSkillTypeHPPlus,
    LWFSkillTypeStrengthPlus,
    LWFSkillTypeSpinningAttackLevelUp,
    LWFSkillTypeLootPlus,
    LWFSkillTypePotionEffectUp,
    LWFSkillTypeArmorUp
} LWFSkillType;

@implementation LWFSkillTree

SINGLETON_FOR_CLASS(SkillTree)



@end
