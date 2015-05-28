//
//  LWFPotionFactory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFPotion;

@interface LWFPotionFactory : NSObject

+ (id)sharedPotionFactory;

- (LWFPotion *)manufactureWithPotionIdentifier:(NSString *)potionIdentifier;

@end
