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

@implementation LWFCombatSystem

+ (LWFCombatOutput *)calculateForAttacker:(id<LWFAttackable>)attacker target:(id<LWFAttackable>)target {
    LWFStats *attackerStats = [attacker getStats];
    LWFEquips *attackerEquips = [attacker getEquips];
    
    LWFStats *targetStats = [target getStats];
    LWFEquips *targetEquips = [target getEquips];
    
    
    
    
    return nil;

}

@end
