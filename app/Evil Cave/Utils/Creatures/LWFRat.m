//
//  LWFRat.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/23/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFRat.h"

@implementation LWFRat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spriteImageName = @"rat";
    }
    return self;
}

- (void)build {
    [super build];
    
}

- (NSArray *)getWalkFrames {
    NSMutableArray *walkFrames = [NSMutableArray array];
    
    for (int i = 1; i <= 2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"rat%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [walkFrames addObject:texture];
    }
    
    return walkFrames;
}

@end
