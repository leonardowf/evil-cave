//
//  LWFAcidPotion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/20/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFAcidPotion.h"
#import "LWFStats.h"
#import "LWFCreature.h"

#import "LWFOTEQueue.h"
#import "LWFOTEPoison.h"

@implementation LWFAcidPotion

- (void)applyEffectOn:(LWFCreature *)creature {
    
    if (self.quantity <= 0) {
        return;
    }
    
    [super applyEffectOn:creature];
    
    LWFStats *creatureStats = creature.stats;
    
    NSInteger totalAfterDamage = creatureStats.currentHP - [self getDamageQuantity];
    
    if (totalAfterDamage <= 0) {
        totalAfterDamage = 0;
    }
    
    creatureStats.currentHP = totalAfterDamage;
    
    [creature statsChanged];
}

- (NSInteger)getDamageQuantity {
    return 20;
}

- (NSString *)identifier {
    return @"acid_potion";
}

@end
