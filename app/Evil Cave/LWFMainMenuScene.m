
//
//  LWFMainMenuScene.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/13/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFMainMenuScene.h"
#import "LWFViewController.h"
#import "LWFViewController+SettingsView.h"

@interface LWFMainMenuScene () {
    SKSpriteNode *_newGameButton;
    SKSpriteNode *_continueButton;
    SKSpriteNode *_logo;
    SKSpriteNode *_background;
    SKSpriteNode *_settingsButton;
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
        _settingsButton = [self settingsButton];
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self addChild:_background];
        [self addChild:_newGameButton];
//        [self addChild:_continueButton];
        [self addChild:_logo];
        [self addChild:_settingsButton];
        
        _logo.size = CGSizeMake(200, 200);
        
        _logo.position = CGPointMake(0, 135);
        _newGameButton.position = CGPointMake(_newGameButton.position.x, _newGameButton.position.y - 20);
        
        _continueButton.position = CGPointMake(_continueButton.position.x, _newGameButton.position.y - _newGameButton.size.height - 20);
        
        _settingsButton.position = CGPointMake(self.frame.size.width / 2 - (_settingsButton.frame.size.width / 2.0), self.frame.size.height / 2 - (_settingsButton.frame.size.height /2.0));
        
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

- (SKSpriteNode *)settingsButton {
    SKSpriteNode *settingsButtonNode = [[SKSpriteNode alloc]initWithImageNamed:@"settings"];
    return settingsButtonNode;
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
    
    if (nodeAtPoint == _settingsButton) {
        [self didTapSettings];
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

- (void)didTapSettings {
    NSLog(@"Settings");
    
    [self.rootViewController showSettingsView];
}

@end
