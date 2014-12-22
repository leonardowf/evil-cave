//
//  LWFDamageDisplayer.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/3/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFDamageDisplayer.h"
#import "LWFTile.h"
#import "LWFMap.h"

#import <SpriteKit/SpriteKit.h>

#import "LWFAttackManager.h"

@interface LWFDamageDisplayer () {
    LWFAttackManager *_delegate;
}

@end

@implementation LWFDamageDisplayer

SINGLETON_FOR_CLASS(LWFDamageDisplayer)

- (void)showString:(NSString *)string atTile:(LWFTile *)tile andDelegate:(LWFAttackManager *)delegate {
    _delegate = delegate;
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [label setFontColor:[UIColor redColor]];

    label.text = @"1";
    label.fontSize = 16;
    label.position = tile.position;
    
    [self.map addChild:label];
    
    SKAction *action = [SKAction moveByX:0 y:20 duration:0.1];
    [label runAction:action completion:^{
        SKAction *action = [SKAction fadeAlphaTo:0 duration:0.2];
        [label runAction:action completion:^{
            [self completed];
        }];
        
    }];
}

- (void)completed {
    [_delegate didShowDamage];
}

@end
