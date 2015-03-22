//
//  LWFLifeBar.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/27/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFLifeBar.h"
#import "LWFStats.h"

@interface LWFLifeBar () {
    SKSpriteNode *_fillGreen;
    SKSpriteNode *_fillLeftCorner;
    SKSpriteNode *_fillRightCorner;
}
@end

@implementation LWFLifeBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        SKTexture *lifebarTexture = [SKTexture textureWithImageNamed:@"creature_lifebar"];
        lifebarTexture.filteringMode = SKTextureFilteringNearest;
        [self setTexture:lifebarTexture];
        [self setSize:lifebarTexture.size];
        
        self.anchorPoint = CGPointMake(0, 0);
        
        _fillGreen = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(28, 2)];
        _fillGreen.anchorPoint =CGPointMake(0, 0);
        [_fillGreen setPosition:CGPointMake(2, 1)];
        
        [self addChild:_fillGreen];
        
        _fillLeftCorner = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(1, 1)];
        _fillLeftCorner.anchorPoint = CGPointMake(0, 0);
        [_fillLeftCorner setPosition:CGPointMake(1, 1)];
        
        [self addChild:_fillLeftCorner];
        
        _fillRightCorner = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(1, 1)];
        _fillRightCorner.anchorPoint =CGPointMake(0, 0);
        [_fillRightCorner setPosition:CGPointMake(self.size.width -2, 2)];
        
        [self addChild:_fillRightCorner];

    }
    return self;
}



- (void)draw {
    if (self.stats.currentHP < self.stats.maxHP) {
        [_fillRightCorner setAlpha:0.0];
    } else {
        [_fillRightCorner setAlpha:1.0];
    }
    
    if (self.stats.currentHP <= 0) {
        [_fillLeftCorner setAlpha:0.0];
    } else {
        [_fillLeftCorner setAlpha:1.0];
    }
    
    CGFloat sizePerHp = (self.size.width - 4) / self.stats.maxHP;
    CGFloat greenSizeWidth = 0.0;
    if (self.stats.currentHP > 0) {
        greenSizeWidth = sizePerHp * self.stats.currentHP;
    }
    
    [_fillGreen setSize:CGSizeMake(greenSizeWidth, _fillGreen.size.height)];
}

@end
