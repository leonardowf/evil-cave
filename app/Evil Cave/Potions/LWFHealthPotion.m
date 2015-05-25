//
//  LWFHealthPotion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFHealthPotion.h"
#import "LWFStats.h"
#import "LWFCreature.h"

@implementation LWFHealthPotion

- (void)applyEffectOn:(LWFCreature *)creature {
    LWFStats *creatureStats = creature.stats;
    
    NSInteger totalAfterHealing = creatureStats.currentHP + [self getHealingQuantity];
    
    if (totalAfterHealing > creatureStats.maxHP) {
        totalAfterHealing = creatureStats.maxHP;
    }
    
    creatureStats.currentHP = totalAfterHealing;
    
}

- (NSInteger)getHealingQuantity {
    return 20;
}

@end
