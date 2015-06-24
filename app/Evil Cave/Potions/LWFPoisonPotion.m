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
    
    LWFOTEPoison *poison = [[LWFOTEPoison alloc]init];
    [poison addObserver:creature];
    [creature.oteQueue addOTE:poison];
}

- (NSString *)identifier {
    return @"poison_potion";
}

@end
