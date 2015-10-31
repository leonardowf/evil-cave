//
//  LWFStats.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFStats.h"
#import "LWFCombatOutput.h"
#import "LWFEquips.h"
#import "LWFSkillTree.h"
#import "LWFKillable.h"

@implementation LWFStats

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
                      andKilladble:(id<LWFKillable>) killable
{
    self = [super init];
    if (self) {
        self.killable = killable;
        
        NSNumber *maxHP = [dictionary objectForKey:@"max_hp"];
        NSNumber *actionPoints = [dictionary objectForKey:@"action_points"];
        NSNumber *strength = [dictionary objectForKey:@"strength"];
        NSNumber *chanceToHit = [dictionary objectForKey:@"chance_to_hit"];
        NSNumber *baseArmor = [dictionary objectForKey:@"base_armor"];
        NSNumber *chanceToEvade = [dictionary objectForKey:@"chance_to_evade"];
        
        self.maxHP = [maxHP unsignedIntegerValue];
        self.actionPoints = [actionPoints unsignedIntegerValue];
        self.strength = [strength unsignedIntegerValue];
        self.chanceToHit = [chanceToHit unsignedIntegerValue];
        self.baseArmor = [baseArmor unsignedIntegerValue];
        self.chanceToEvade = [chanceToEvade unsignedIntegerValue];
        
        self.currentActions = self.actionPoints;
        
        [self reloadStats];

        self.currentHP = self.maxHP;
    }
    return self;
}

- (void)reloadStats {
    LWFSkillTree *skillTree = [self.killable getSkillTree];
    
    if (skillTree != nil) {
        self.maxHP = self.maxHP + [skillTree bonusForSkillType:LWFSkillTypeHPPlus];
    }
}

- (void)receivesCombatOutput:(LWFCombatOutput *)combatOutput {
    self.currentHP = self.currentHP - combatOutput.damage;
    [self.killable statsChanged];
}

- (NSInteger)maxHP {
    LWFEquips *equips = [self.killable getEquips];
    NSInteger bonusHp = 0;
    
    if (equips != nil) {
        bonusHp = [equips totalHP];
    }
    
    return _maxHP + bonusHp;
}

- (NSInteger)strength {
    LWFSkillTree *skillTree = [self.killable getSkillTree];
    
    if (skillTree == nil) {
        return _strength;
    }
    
    return _strength + [skillTree bonusForSkillType:LWFSkillTypeStrengthPlus];
}

- (NSInteger)baseArmor {
    LWFSkillTree *skillTree = [self.killable getSkillTree];
    
    if (skillTree == nil) {
        return _baseArmor;
    }
    
    return _baseArmor + [skillTree bonusForSkillType:LWFSkillTypeArmorUp];
}

@end
