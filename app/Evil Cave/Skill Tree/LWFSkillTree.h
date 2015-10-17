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
    LWFSkillTypeArmorUp
} LWFSkillType;

@interface LWFSkillTree : NSObject

+ (id)sharedSkillTree;

@end