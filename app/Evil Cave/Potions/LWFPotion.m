//
//  LWFPotion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotion.h"
#import "LWFCreature.h"

@implementation LWFPotion

- (BOOL)isPotion {
    return YES;
}

- (BOOL)isStackable {
    return YES;
}

- (BOOL)isUsable {
    return YES;
}

- (void)applyEffectOn:(LWFCreature *)creature {
    
}

- (BOOL)canStackWith:(LWFNewItem *)item {
    if ([item isPotion] && [item.identifier isEqualToString:self.identifier]) {
        return YES;
    }
    
    return NO;
}

- (LWFNewItem *)stackWithItem:(LWFNewItem *)item {
    self.quantity = self.quantity + item.quantity;
    item.quantity = 0;
    
    return self;
}

@end
