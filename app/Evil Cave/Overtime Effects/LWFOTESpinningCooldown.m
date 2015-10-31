//
//  LWFOTESpinningCooldown.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/28/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFOTESpinningCooldown.h"

@implementation LWFOTESpinningCooldown

- (instancetype)init
{
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    NSInteger removedCoolDown = [skillTree bonusForSkillType:LWFSkillTypeSpinningAttackLevelUp];
    NSInteger numberOfTurns = 20 - removedCoolDown;
    if (numberOfTurns < 0) {
        return 0;
    }
    
    self = [super initWithNumberOfTurns:numberOfTurns];
    if (self) {
        
    }
    return self;
}

@end
