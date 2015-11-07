//
//  LWFPoisonPotion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/23/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPoisonPotion.h"
#import "LWFCreature.h"
#import "LWFOTEPoison.h"
#import "LWFOTEQueue.h"

@implementation LWFPoisonPotion

- (void)applyEffectOn:(LWFCreature *)creature {
    if (self.quantity <= 0) {
        return;
    }
    
    [super applyEffectOn:creature];
    
    if (creature == nil) {
        return;
    }
    
    LWFOTEPoison *poison = [[LWFOTEPoison alloc]init];
    poison.damage = [self poisonDamage];
    [poison addObserver:creature];
    [creature.oteQueue addOTE:poison];
}

- (NSInteger)poisonDamage {
    return 1 + [self baseModifier];
}

- (NSInteger)numberOfTurns {
    LWFOTEPoison *poison = [[LWFOTEPoison alloc]init];
    
    return poison.numberOfTurns - 1;
}

- (NSString *)identifier {
    return @"poison_potion";
}

- (NSString *)useDescription {
    return [NSString stringWithFormat:@"When consumed, this potion will poison the player. This causes %dHP of damage per turn, for %d turns. It can be thrown against enemies.", [self poisonDamage], [self numberOfTurns]];
}



@end
