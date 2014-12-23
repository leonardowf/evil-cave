//
//  LWFCombatSystem.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCombatSystem.h"
#import "LWFCombatOutput.h"

#import "LWFAttackable.h"

#import "LWFStats.h"
#import "LWFAttack.h"

#import "LWFRandomUtils.h"

@implementation LWFCombatSystem

+ (LWFCombatOutput *)calculateForAttacker:(id<LWFAttackable>)attacker
                                   target:(id<LWFAttackable>)target
                               withAttack:(LWFAttack *)attack {
    
    // TODO: por equips e chance de miss
    
    LWFStats *attackerStats = [attacker getStats];
    LWFEquips *attackerEquips = [attacker getEquips];
    
    LWFStats *targetStats = [target getStats];
    LWFEquips *targetEquips = [target getEquips];
    
    NSUInteger strModifier = 100 + attackerStats.strength;
    float newMinimum = (strModifier * attack.minimumDamage) / 100;
    float newMaximum = (strModifier * attack.maximumDamage) / 100;
    
    NSUInteger newMinimumInt = (newMinimum + 0.5);
    NSUInteger newMaximumInt = (newMaximum + 0.5);
    
    LWFRandomUtils *randomizer = [[LWFRandomUtils alloc]init];
    
    NSUInteger randomized = [randomizer randomIntegerBetween:newMinimumInt and:newMaximumInt];
    
    NSInteger damage = randomized - [targetStats baseArmor];
    
    if (damage < 0) damage = 0;
    
    LWFCombatOutput *combatOutput = [[LWFCombatOutput alloc]init];
    combatOutput.damage = damage;
    
    return combatOutput;

}

@end
