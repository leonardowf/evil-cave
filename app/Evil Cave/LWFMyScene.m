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
        
        self.backgroundColor = [UIColor blackColor];
        
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
    SKSpriteNode *loadingNode = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:_size];
    loadingNode.position = CGPointMake(_size.width/2, _size.height/2);
    loadingNode.alpha = 0.0;
    SKAction *fadeaction = [SKAction fadeAlphaTo:1 duration:0.5];
    [loadingNode setZPosition:1000];
    [loadingNode runAction:fadeaction completion:^{
        CGFloat yScale;
        CGFloat xScale = yScale = 1.0;
        
        if (_map != nil) {
            xScale = _map.xScale;
            yScale = _map.yScale;
        }
        
        [_map removeFromParent];
        
        LWFMapDimension *mapDimension = [[LWFMapDimension alloc]initWithGridSize:_size numberTilesVertical:17 numberTilesHorizontal:17 andTileSize:TILE_SIZE];
        
        _map = [[LWFMap alloc]initWithMapDimension:mapDimension];
        
        _map.xScale = xScale;
        _map.yScale = yScale;
        
        [_map addTiles];
        [_map loadGame];
        
        [self addChild:_map];
        [_map moveCameraToTile:_map.player.currentTile completion:^{
            SKAction *fadeaction = [SKAction fadeAlphaTo:0 duration:0.5];
            [loadingNode runAction:fadeaction];
        }];
    }];
    [self addChild:loadingNode];
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
