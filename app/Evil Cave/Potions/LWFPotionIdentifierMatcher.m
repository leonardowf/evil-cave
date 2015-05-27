//
//  LWFPotionIdentifierMatcher.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotionIdentifierMatcher.h"

@interface LWFPotionIdentifierMatcher () {
    NSMutableArray *_knowFlavors;
    NSMutableArray *_unknowFlavors;
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
    }
    return self;
}

- (NSArray *)allowedPotions {
    return @[@"health_potion"];
}

- (NSArray *)allowedTextures {
    return @[@"red_potion"];
}

- (SKTexture *)textureForPotionIdentifier:(NSString *)potionIdentifier {
    return nil;
}

@end
