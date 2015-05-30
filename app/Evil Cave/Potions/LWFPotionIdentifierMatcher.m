//
//  LWFPotionIdentifierMatcher.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotionIdentifierMatcher.h"
#import "NSMutableArray_Shuffling.h"

@interface LWFPotionIdentifierMatcher () {
    NSMutableArray *_knowFlavors;
    NSMutableArray *_unknowFlavors;
    
    NSDictionary *_identifierTextureDictionary;
}
@end

@implementation LWFPotionIdentifierMatcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        _knowFlavors = [NSMutableArray array];
        _unknowFlavors = [NSMutableArray array];
        
        NSArray *allowed = [self allowedPotions];
        [_unknowFlavors addObjectsFromArray:allowed];
        
        [self matchTexturesAndIdentifiers];
    }
    return self;
}

- (void)matchTexturesAndIdentifiers {
    NSMutableDictionary *identifierTextureDictionary = [NSMutableDictionary dictionary];
    
    NSMutableArray *shuffledTextures = [NSMutableArray arrayWithArray:[self allowedTextures]];
    [shuffledTextures shuffle];
    
    NSArray *potionIdentifiers = [self allowedPotions];
    
    for (NSInteger i = 0; i < potionIdentifiers.count; i++) {
        NSString *textureIdentifier = [shuffledTextures objectAtIndex:i];
        NSString *potionIdenfitier = [potionIdentifiers objectAtIndex:i];
        
        [identifierTextureDictionary setObject:textureIdentifier forKey:potionIdenfitier];
    }
}

- (NSArray *)allowedPotions {
    return @[@"health_potion"];
}

- (NSArray *)allowedTextures {
    return @[@"red_potion"];
}

- (SKTexture *)textureForPotionIdentifier:(NSString *)potionIdentifier {
    NSString *textureName = [_identifierTextureDictionary objectForKey:potionIdentifier];
    SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
    [texture setFilteringMode:SKTextureFilteringNearest];
    
    return texture;
}

- (void)setPotionWithIdentifierAsKnow:(NSString *)string {
    [_unknowFlavors removeObject:string];
    [_knowFlavors addObject:string];
}

- (BOOL)potionWithIdentifierIsKnow:(NSString *)potionIdentifier {
    return [_knowFlavors containsObject:potionIdentifier];
}

@end
