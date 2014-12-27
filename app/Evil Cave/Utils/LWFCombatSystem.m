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
    
    // TODO: por equips
    
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

//+ (CGFloat)attacker:(id<LWFAttackable>)attacker chanceToHitTarget:(id<LWFAttackable>)target
//         withAttack:(LWFAttack *)attack {
//    
//    LWFStats *attackerStats = [attacker getStats];
//    LWFEquips *attackerEquips = [attacker getEquips];
//    
//    LWFStats *targetStats = [target getStats];
//    LWFEquips *targetEquips = [target getEquips];
//    
//    CGFloat A = attackerStats.chanceToHit;
//    CGFloat B = targetStats.chanceToEvade;
//    CGFloat C = A - B;
//    
//    CGFloat F1 = 2 / M_PI;
//    CGFloat F2 = C - 50;
//    CGFloat F3 = F2 / 40;
//    CGFloat F4 = atan(F3);
//    CGFloat F5 = F1 * F4;
//    CGFloat F6 = 1 + F5;
//    
//    CGFloat F = F6 * 50;
//    
//    return F;
//}
/*
 Source: https://code.google.com/p/andors-trail/wiki/combat
 
 1) Determine the attacker's chance to hit. Call this A. (This value might be greaten than 100)
 2) Determine the target's block chance. Call this B.
 3) Calculate C = A - B
 4) Calculate F = 50 * (1 + (2/pi) * ATAN( (C - 50) / 40 ) )
    -> This function will produce a number between 0 and 100.
    -> If C is 50, then F will be 50.
    -> If C is high (the attacker's chance to hit is higher than the target's block chance), then F will be near 100.
    -> If C is low, then F will be 50.
 5) The chance to hit (in percent) is F.
 */
@end
