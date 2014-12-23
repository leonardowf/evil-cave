//
//  LWFCombatSystem.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LWFCombatOutput.h"
#import "LWFAttackable.h"

@interface LWFCombatSystem : NSObject

+ (LWFCombatOutput *)calculateForAttacker:(id<LWFAttackable>)attacker
                                   target:(id<LWFAttackable>)target
                               withAttack:(LWFAttack *)attack;

@end
