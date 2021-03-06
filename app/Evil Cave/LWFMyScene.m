//
//  LWFMyScene.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFMyScene.h"
#import "LWFGameController.h"

#import "LWFMap.h"
#import "LWFMapDimension.h"
#import "LWFTile.h"
#import "LWFPlayer.h"
#import "LWFGeometry.h"
#import "LWFInventory.h"
#import "LWFSoundPlayer.h"

@interface LWFMyScene () {
    LWFMap *_map;
    CGSize _size;
    NSInteger _currentFloor;
    
    UIPinchGestureRecognizer *_pinchGestureRecognizer;
    UIPanGestureRecognizer *_panGestureRecognizer;
    UITapGestureRecognizer *_tapGestureRecognizer;
    BOOL _pinching;
    UITouch *_lastTouch;
    
    LWFSoundPlayer *_soundPlayer;
}
@end

@implementation LWFMyScene

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {        
        self.backgroundColor = [UIColor blackColor];
        
        _size = size;
        _currentFloor = 0;
        [self nextLevel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(nextLevel)
                                                     name:@"notificationNextLevel"
                                                   object:nil];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(restart)
                                                     name:@"notificationRestartGame"
                                                   object:nil];
        
    }
    return self;
}

- (void)nextLevel {
    _currentFloor++;
    [_map blockUserInteraction];
    
    SKSpriteNode *loadingNode = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:_size];
    loadingNode.position = CGPointMake(_size.width/2, _size.height/2);
    loadingNode.alpha = 0.0;
    SKAction *fadeaction = [SKAction fadeAlphaTo:1 duration:0.5];
    [loadingNode setZPosition:ZPOSITION_LOADING_OVERLAY];
    [loadingNode runAction:fadeaction completion:^{
        CGFloat yScale;
        CGFloat xScale = yScale = 1.0;
        
        if (_map != nil) {
            xScale = _map.xScale;
            yScale = _map.yScale;
        }
        
        [_map removeFromParent];
        
        _map = [[LWFMap alloc]initWithScreenSize:_size andFloor:_currentFloor];
        [[LWFGameController sharedGameController]setMap:_map];
        
        _map.xScale = xScale;
        _map.yScale = yScale;
        
        [_map build];
        [_map addTiles];
        [_map loadGame];
        
        [self addChild:_map];
        
        // TODO: Refactor, callback hell
        [_map moveCameraToTile:_map.player.currentTile completion:^{
            SKAction *fadeaction = [SKAction fadeAlphaTo:0 duration:0.5];
            [loadingNode runAction:fadeaction completion:^{
                [_map unblockUserInteraction];
            }];
        }];
    }];
    [self addChild:loadingNode];
}

- (void)restart {
    _currentFloor = 0;
    [self nextLevel];
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
        LWFInventory *inventory = [LWFInventory sharedInventory];
        if ([inventory isOpen]) {
            return;
        }
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(-translation.x, translation.y);
        
        
        _map.position = CGPointSubtract(_map.position, translation);
        
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        // No code needed for panning.
    }
}

- (void)handleZoomFrom:(UIPinchGestureRecognizer *)recognizer
{
    CGPoint anchorPoint = [recognizer locationInView:recognizer.view];
    anchorPoint = [self convertPointFromView:anchorPoint];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        if (_map.xScale > MAX_ZOOM_IN && recognizer.scale >= 1.0) {
            return;
        }
        
        if (_map.xScale < MAX_ZOOM_OUT && recognizer.scale < 1.0) {
            return;
        }
        
        CGPoint anchorPointInMySkNode = [_map convertPoint:anchorPoint fromNode:self];
        
        [_map setScale:(_map.xScale * recognizer.scale)];
        
        CGPoint mySkNodeAnchorPointInScene = [self convertPoint:anchorPointInMySkNode fromNode:_map];
        CGPoint translationOfAnchorInScene = CGPointSubtract(anchorPoint, mySkNodeAnchorPointInScene);
        
        _map.position = CGPointAdd(_map.position, translationOfAnchorInScene);
        
        recognizer.scale = 1.0;
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
    }
}
@end
