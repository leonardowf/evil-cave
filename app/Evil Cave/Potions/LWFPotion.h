//
//  LWFPotion.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFNewItem.h"
@class LWFPotionIdentifierMatcher;

@interface LWFPotion : LWFNewItem

- (void)applyEffectOn:(LWFCreature *)creature;
- (void)setPotionIdentifierMatcher:(LWFPotionIdentifierMatcher *)potionIdentifierMatcher;
- (BOOL)isKnow;

@end
