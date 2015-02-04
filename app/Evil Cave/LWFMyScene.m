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
    
    CGSize _size;
}
@end

@implementation LWFMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        _size = size;
        [self nextLevel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(nextLevel)
                                                     name:@"notificationNextLevel"
                                                   object:nil];

        
    }
    return self;
}

- (void)nextLevel {
    CGFloat yScale;
    CGFloat xScale = yScale = 1.0;
    
    if (_map != nil) {
        xScale = _map.xScale;
        yScale = _map.yScale;
    }
    
    [_map removeFromParent];
    
    LWFMapDimension *mapDimension = [[LWFMapDimension alloc]initWithGridSize:_size numberTilesVertical:13 numberTilesHorizontal:13 andTileSize:TILE_SIZE];
    
    _map = [[LWFMap alloc]initWithMapDimension:mapDimension];
    
    _map.xScale = xScale;
    _map.yScale = yScale;
    
    [_map addTiles];
    [_map loadGame];
    
    [self addChild:_map];
    [_map moveCameraToTile:_map.player.currentTile];
    

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
