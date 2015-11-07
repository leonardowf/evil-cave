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
    
    if (self.quantity <= 0) {
        return;
    }
    
    [super applyEffectOn:creature];
    
    if (creature == nil) {
        return;
    }
    
    LWFStats *creatureStats = creature.stats;
    
    NSInteger totalAfterHealing = creatureStats.currentHP + [self getHealingQuantity];
    
    if (totalAfterHealing > creatureStats.maxHP) {
        totalAfterHealing = creatureStats.maxHP;
    }
    
    creatureStats.currentHP = totalAfterHealing;
    
    [creature statsChanged];
}

- (NSInteger)getHealingQuantity {
    return 20 + [self baseModifier];
}

- (NSString *)identifier {
    return @"health_potion";
}

- (NSString *)useDescription {
    return [NSString stringWithFormat:@"When consumed, this potion will restore %dHP of the player. It also can be thrown against enemies if you're stupid enough.", [self getHealingQuantity]];
}

@end
