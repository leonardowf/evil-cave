//
//  LWFAtlasSpriteLoader.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 9/14/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFAtlasSpriteLoader.h"
#import <SpriteKit/SpriteKit.h>

@implementation LWFAtlasSpriteLoader

+ (NSArray *)spritesWithAtlasName:(NSString *)atlasName {
    NSMutableArray *resultArray = [NSMutableArray array];
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    
    NSUInteger numImages = atlas.textureNames.count;
    for (int i = 1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", atlasName, i];
        SKTexture *texture = [atlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [resultArray addObject:texture];
    }
    
    return resultArray;
}

@end
