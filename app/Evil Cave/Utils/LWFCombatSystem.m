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
#import "LWFEquips.h"

#import "LWFRandomUtils.h"

@implementation LWFCombatSystem

+ (LWFCombatOutput *)calculateForAttacker:(id<LWFAttackable>)attacker
                                   target:(id<LWFAttackable>)target
                               withAttack:(LWFAttack *)attack {
    
    LWFCombatOutput *combatOutput = nil;
    
    if ([LWFCombatSystem attacker:attacker didHitTarget:target withAttack:attack]) {
        combatOutput = [LWFCombatSystem damageCombatOutputForAttacker:attacker target:target withAttack:attack];
    } else {
        combatOutput = [[LWFCombatOutput alloc]init];
        combatOutput.combatOutputType = LWFCombatOutputTypeMiss;
    }
    
    return combatOutput;
}

+ (LWFCombatOutput *)damageCombatOutputForAttacker:(id<LWFAttackable>)attacker
                                            target:(id<LWFAttackable>)target
                                        withAttack:(LWFAttack *)attack {
    
    LWFStats *attackerStats = [attacker getStats];
    LWFEquips *attackerEquips = [attacker getEquips];
    
    LWFStats *targetStats = [target getStats];
    LWFEquips *targetEquips = [target getEquips];
    
    NSInteger strModifier = 100 + (attackerStats.strength + [attackerEquips totalStrength]);
    float newMinimum = (strModifier * (attack.minimumDamage + [attackerEquips totalMinDamage])) / 100;
    float newMaximum = (strModifier * (attack.maximumDamage + [attackerEquips totalMaxDamage])) / 100;
    
    NSInteger newMinimumInt = (newMinimum + 0.5);
    NSInteger newMaximumInt = (newMaximum + 0.5);
    
    LWFRandomUtils *randomizer = [[LWFRandomUtils alloc]init];
    
    NSInteger randomized = [randomizer randomIntegerBetween:newMinimumInt and:newMaximumInt];
    
    NSInteger damage = randomized - ([targetStats baseArmor] + [targetEquips totalArmor]);
    
    if (damage < 0) damage = 0;
    
    LWFCombatOutput *combatOutput = [[LWFCombatOutput alloc]init];
    combatOutput.damage = damage;
    
    combatOutput.combatOutputType = LWFCombatOutputTypeHit;
    
    return combatOutput;
    
}

+ (BOOL)attacker:(id<LWFAttackable>)attacker didHitTarget:(id<LWFAttackable>)target
      withAttack:(LWFAttack *)attack {
    
    CGFloat chanceToHit = [LWFCombatSystem attacker:attacker chanceToHitTarget:target withAttack:attack];
    
    LWFRandomUtils *randomUtils = [[LWFRandomUtils alloc]init];
    
    NSInteger randomized = [randomUtils randomIntegerBetween:1 and:100];
    
    if (randomized > chanceToHit) {
        return NO;
    }
    
    return YES;
    
}
// Source: http://gaming.stackexchange.com/questions/144618/how-does-the-chance-to-hit-or-accuracy-work-in-path-of-exile
// Attacker's Accuracy / ( Attacker's Accuracy + ((Defender's Evasion / 4) ^ 0.8) )
+ (CGFloat)attacker:(id<LWFAttackable>)attacker chanceToHitTarget:(id<LWFAttackable>)target
         withAttack:(LWFAttack *)attack {
    
    // TODO: Implementar chance to hit nos equips
    
    LWFStats *attackerStats = [attacker getStats];
    LWFEquips *attackerEquips = [attacker getEquips];
    
    LWFStats *targetStats = [target getStats];
    LWFEquips *targetEquips = [target getEquips];
    
    CGFloat attackersAccuracy = attackerStats.chanceToHit;
    CGFloat defendersEvasion = targetStats.chanceToEvade;
    
    CGFloat f1 = defendersEvasion / 4;
    CGFloat f2 = powf(f1, 0.8);
    CGFloat f3 = attackersAccuracy + f2;
    
    CGFloat f = attackersAccuracy / f3;
    
    if (f < 0) f = 0;
    if (f > 95.0) f = 95.0;

    return f * 100;
}
@end
