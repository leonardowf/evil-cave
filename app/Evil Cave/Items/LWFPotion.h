//
//  LWFPotion.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItem.h"
@class LWFPotionIdentifierMatcher;

@interface LWFPotion : LWFItem

- (void)applyEffectOn:(LWFCreature *)creature;
- (void)setPotionIdentifierMatcher:(LWFPotionIdentifierMatcher *)potionIdentifierMatcher;
- (BOOL)isKnow;
- (NSInteger)baseModifier;

@end
