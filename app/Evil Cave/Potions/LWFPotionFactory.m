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
    }
    
    return potion;
}



@end
