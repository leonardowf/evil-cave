
//
//  LWFMainMenuScene.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/13/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFMainMenuScene.h"
#import "LWFViewController.h"

@interface LWFMainMenuScene () {
    SKSpriteNode *_newGameButton;
    SKSpriteNode *_continueButton;
    SKSpriteNode *_logo;
    SKSpriteNode *_background;
}
@end

@implementation LWFMainMenuScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor blackColor];
        
        _background = [[SKSpriteNode alloc]initWithImageNamed:@"bg_menu"];
        _background.size = size;
        _background.position = CGPointZero;
        
        _newGameButton = [self newGameButton];
        _continueButton = [self continueButton];
        _logo = [self logo];
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self addChild:_background];
        [self addChild:_newGameButton];
//        [self addChild:_continueButton];
        [self addChild:_logo];
        
        _logo.size = CGSizeMake(200, 200);
        
        _logo.position = CGPointMake(0, 135);
        _newGameButton.position = CGPointMake(_newGameButton.position.x, _newGameButton.position.y - 20);
        
        _continueButton.position = CGPointMake(_continueButton.position.x, _newGameButton.position.y - _newGameButton.size.height - 20);
        
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

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pointInScene = [touch locationInNode:self];
    
    SKNode *nodeAtPoint = [self nodeAtPoint:pointInScene];
    
    if (nodeAtPoint == _newGameButton) {
        [self didTapNewGame];
        return;
    }
    
    
    if (nodeAtPoint == _continueButton) {
        [self didTapContinueGame];
        return;
    }
}

- (void)didTapNewGame {
    NSLog(@"New Game");
    
    [self.rootViewController startGameSceneAnimated:true];
}

- (void)didTapContinueGame {
    NSLog(@"Continue");
}

@end
