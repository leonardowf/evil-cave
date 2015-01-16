//
//  LWFMyScene.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFMyScene.h"

#import "LWFMap.h"
#import "LWFMapDimension.h"
#import "LWFTile.h"
#import "LWFPlayer.h"
#import "LWFGeometry.h"
#import "LWFInventory.h"

@interface LWFMyScene () {
    LWFMap *_map;
    UIPinchGestureRecognizer *_pinchGestureRecognizer;
    UIPanGestureRecognizer *_panGestureRecognizer;
    UITapGestureRecognizer *_tapGestureRecognizer;
    
    BOOL _pinching;
    
    UITouch *_lastTouch;
    
    SKSpriteNode *_inventoryButton;
}
@end

@implementation LWFMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        LWFMapDimension *mapDimension = [[LWFMapDimension alloc]initWithGridSize:size numberTilesVertical:23 numberTilesHorizontal:23 andTileSize:TILE_SIZE];
        
        _map = [[LWFMap alloc]initWithMapDimension:mapDimension];
        [_map addTiles];
        [_map loadGame];
        
        [self addChild:_map];
        [_map moveCameraToTile:_map.player.currentTile];
        
        [self constructHudForSize:size];
        
    }
    return self;
}

- (void)constructHudForSize:(CGSize)size {
    SKSpriteNode *hudNode = [[SKSpriteNode alloc]initWithColor:[UIColor greenColor] size:CGSizeMake(size.width, 60)];
    _inventoryButton = [[SKSpriteNode alloc]initWithColor:[UIColor redColor] size:CGSizeMake(60, hudNode.size.height)];
    
    _inventoryButton.position = CGPointMake(hudNode.size.width/2 - _inventoryButton.size.width/2, 0);
    
    [hudNode addChild:_inventoryButton];

    hudNode.position = CGPointMake(hudNode.size.width/2, hudNode.size.height/2);
    
    [self addChild:hudNode];
}

- (void)openInventory {
    LWFInventory *inventory = [LWFInventory sharedInventory];
    
    CGFloat inventHeight = self.size.height - 50;
    CGFloat inventWidth = self.size.width - 50;
    
    CGSize size = CGSizeMake(inventWidth, inventHeight);
    
    CGFloat x = self.size.width / 2;
    CGFloat y = self.size.height / 2;
    
    CGPoint position = CGPointMake(x, y);
    
    [inventory setSize:size];
    [inventory setPosition:position];
    
    [inventory setColor:[UIColor orangeColor]];
    
    if (![self.children containsObject:inventory]) {
        [self addChild:inventory];
    } else {
        [inventory removeFromParent];
    }
}

-(void)update:(CFTimeInterval)currentTime {

}

- (void)didMoveToView:(SKView *)view {
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [_panGestureRecognizer setMinimumNumberOfTouches:1];
    [[self view] addGestureRecognizer:_panGestureRecognizer];
    
    _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleZoomFrom:)];
    [[self view] addGestureRecognizer:_pinchGestureRecognizer];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    _tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:_tapGestureRecognizer];
    
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    UITouch *touch = _lastTouch;
    CGPoint positionInScene = [touch locationInNode:self];

    NSArray *nodes = [self nodesAtPoint:positionInScene];

    if ([nodes containsObject:_inventoryButton]) {
        [self openInventory];
        return;
    }

    CGPoint touchPoint = [touch locationInNode:_map];

    [_map userTouchedPoint:touchPoint];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == _tapGestureRecognizer) {
        _lastTouch = touch;
    }
    
    return YES;
}


- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(-translation.x, translation.y);
        
        
        _map.position = CGPointSubtract(_map.position, translation);
        
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        // No code needed for panning.
    }
}

// Method that is called by my UIPinchGestureRecognizer.
- (void)handleZoomFrom:(UIPinchGestureRecognizer *)recognizer
{
    CGPoint anchorPoint = [recognizer locationInView:recognizer.view];
    anchorPoint = [self convertPointFromView:anchorPoint];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        // No code needed for zooming...
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint anchorPointInMySkNode = [_map convertPoint:anchorPoint fromNode:self];
        
        [_map setScale:(_map.xScale * recognizer.scale)];
        
        CGPoint mySkNodeAnchorPointInScene = [self convertPoint:anchorPointInMySkNode fromNode:_map];
        CGPoint translationOfAnchorInScene = CGPointSubtract(anchorPoint, mySkNodeAnchorPointInScene);
        
        _map.position = CGPointAdd(_map.position, translationOfAnchorInScene);
        
        recognizer.scale = 1.0;
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        // No code needed here for zooming...
        
    }
}
@end
