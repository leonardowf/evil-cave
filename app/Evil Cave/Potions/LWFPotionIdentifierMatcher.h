//
//  LWFPotionIdentifierMatcher.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface LWFPotionIdentifierMatcher : NSObject

- (SKTexture *)textureForPotionIdentifier:(NSString *)potionIdentifier;
- (NSArray *)allowedPotions;
- (NSArray *)allowedTextures;
- (BOOL)potionWithIdentifierIsKnow:(NSString *)potionIdentifier;
- (void)setPotionWithIdentifierAsKnow:(NSString *)string;
- (NSString *)textureNameForPotionIdentifier:(NSString *)potionIdentifier;

@end
