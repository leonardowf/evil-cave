//
//  LWFPotion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotion.h"
#import "LWFCreature.h"
#import "LWFPotionIdentifierMatcher.h"

@interface LWFPotion () {
    LWFPotionIdentifierMatcher *_potionIdentifierMatcher;
}
@end

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
    [_potionIdentifierMatcher setPotionWithIdentifierAsKnow:self.identifier];
    self.quantity = self.quantity - 1;
}

- (BOOL)canStackWith:(LWFItem *)item {
    if ([item isPotion] && [item.identifier isEqualToString:self.identifier]) {
        return YES;
    }
    
    return NO;
}

- (LWFItem *)stackWithItem:(LWFItem *)item {
    self.quantity = self.quantity + item.quantity;
    item.quantity = 0;
    
    return self;
}

- (void)setPotionIdentifierMatcher:(LWFPotionIdentifierMatcher *)potionIdentifierMatcher {
    _potionIdentifierMatcher = potionIdentifierMatcher;
}

- (BOOL)isKnow {
    return [_potionIdentifierMatcher potionWithIdentifierIsKnow:self.identifier];
}

- (UIImage *)getImage {
    UIImage *itemImage = [UIImage imageNamed:self.imageName];
    
    return itemImage;
}

- (NSString *)getName {
    if ([self isKnow]) {
        return self.name;
    } else {
        return @"Unknown potion";
    }
}

- (NSString *)getUseDescription {
    if ([self isKnow]) {
        return [self useDescription];
    } else {
        return [self unknowUseDescription];
    }
}

- (NSString *)useDescription {
    return @"";
}

- (NSString *)unknowUseDescription {
    return @"You've never seen this potion before, who knows what effects it may cause?";
}

- (NSInteger)baseModifier {
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    return [skillTree bonusForSkillType:LWFSkillTypePotionEffectUp];
}

@end
