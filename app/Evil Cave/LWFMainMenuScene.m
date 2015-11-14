
//
//  LWFMainMenuScene.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/13/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFMainMenuScene.h"

@implementation LWFMainMenuScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor purpleColor];
        
        SKSpriteNode *node = [[SKSpriteNode alloc]initWithImageNamed:@"bg_menu"];
        node.size = size;
        node.position = CGPointZero;
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self addChild:node];
        
    }
    return self;
}

@end
