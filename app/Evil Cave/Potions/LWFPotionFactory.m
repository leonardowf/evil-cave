//
//  LWFPotionFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotionFactory.h"
#import "LWFHealthPotion.h"
#import "LWFPotionIdentifierMatcher.h"
#import "LWFAcidPotion.h"
#import "LWFPoisonPotion.h"

@interface LWFPotionFactory () {
    LWFPotionIdentifierMatcher *_potionIdentifierMatcher;
}
@end

@implementation LWFPotionFactory

SINGLETON_FOR_CLASS(PotionFactory)

- (instancetype)init {
    self = [super init];
    if (self) {
        _potionIdentifierMatcher = [[LWFPotionIdentifierMatcher alloc]init];
    }
    return self;
}

- (LWFPotion *)manufactureWithPotionIdentifier:(NSString *)potionIdentifier {
    LWFPotion *potion;
    SKTexture *texture = [_potionIdentifierMatcher textureForPotionIdentifier:potionIdentifier];
    
    if ([potionIdentifier isEqualToString:@"health_potion"]) {
        potion = [[LWFHealthPotion alloc]initWithTexture:texture];
    } else if ([potionIdentifier isEqualToString:@"acid_potion"]) {
        potion = [[LWFAcidPotion alloc]initWithTexture:texture];
    } else if ([potionIdentifier isEqualToString:@"poison_potion"]) {
        potion = [[LWFPoisonPotion alloc]initWithTexture:texture];
    }
    
    potion.quantity = 1;
    [potion setName:@""];
    
    [potion setPotionIdentifierMatcher:_potionIdentifierMatcher];
    potion.imageName = [_potionIdentifierMatcher textureNameForPotionIdentifier:potionIdentifier];
    return potion;
}

- (void)resetPotionKnowledgeAndTextures {
    _potionIdentifierMatcher = [[LWFPotionIdentifierMatcher alloc]init];

}

@end
