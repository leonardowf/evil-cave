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
    
    NSMutableArray *_queue;
}

@end

@implementation LWFDamageDisplayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [NSMutableArray array];
    }
    return self;
}

SINGLETON_FOR_CLASS(LWFDamageDisplayer)

- (void)showString:(NSString *)string atTile:(LWFTile *)tile andDelegate:(LWFAttackManager *)delegate {
    BOOL shouldTrigger = _queue.count == 0;
    
    [_queue addObject:@{@"tile": tile, @"string": string}];
    
    _delegate = delegate;
    
    if (shouldTrigger) {
        [self show];
    }

    [self completed];

}

- (void)show {
    if (_queue.count == 0) {
        return;
    }
    
    NSLog(@"tem na fila : %d", _queue.count);
    
    NSDictionary *dict = [_queue firstObject];
    
    NSString *string = [dict objectForKey:@"string"];
    LWFTile *tile = [dict objectForKey:@"tile"];
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Munro"];
    [label setFontColor:[UIColor redColor]];
    
    label.text = string;
    label.fontSize = 16;
    label.position = tile.position;
    
    [self.map addChild:label];
    
    SKAction *action = [SKAction moveByX:0 y:20 duration:1.0];
    [label runAction:action completion:^{
        SKAction *action = [SKAction fadeAlphaTo:0 duration:0.2];
        [label runAction:action completion:^{
            [_queue removeObject:dict];
            [self show];

        }];
        
    }];
}

- (void)completed {
    [_delegate didShowDamage];
}

@end
