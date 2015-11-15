
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
        
        SKSpriteNode *newGameButton = [self newGameButton];
        SKSpriteNode *continueButton = [self continueButton];
        SKSpriteNode *logo = [self logo];
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self addChild:node];
        [self addChild:newGameButton];
        [self addChild:continueButton];
        [self addChild:logo];
        
        logo.size = CGSizeMake(200, 200);
        
        logo.position = CGPointMake(0, 135);
        newGameButton.position = CGPointMake(newGameButton.position.x, newGameButton.position.y - 20);
        
        continueButton.position = CGPointMake(continueButton.position.x, newGameButton.position.y - newGameButton.size.height - 20);
        
    }
    return self;
}

- (SKSpriteNode *)newGameButton {
    SKSpriteNode *newButtonNode = [[SKSpriteNode alloc]initWithImageNamed:@"btn-new-game"];
    return newButtonNode;
}

- (SKSpriteNode *)continueButton {
    SKSpriteNode *continueButtonNode = [[SKSpriteNode alloc]initWithImageNamed:@"btn-continue"];
    return continueButtonNode;
}

- (SKSpriteNode *)logo {
    SKSpriteNode *logoNode = [[SKSpriteNode alloc]initWithImageNamed:@"logo_menu"];
    return logoNode;
}

@end
