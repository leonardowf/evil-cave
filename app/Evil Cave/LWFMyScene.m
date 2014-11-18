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

@interface LWFMyScene () {
    LWFPlayer *_player;
    LWFMap *_map;
}
@end

@implementation LWFMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        LWFMapDimension *mapDimension = [[LWFMapDimension alloc]initWithGridSize:size numberTilesVertical:40 numberTilesHorizontal:40 andTileSize:32];
        
        _map = [[LWFMap alloc]initWithMapDimension:mapDimension];
        [_map addTiles];
        
        _player = [[LWFPlayer alloc]initWithImageNamed:@"grass"];
        _player.size = mapDimension.tileSize;
        _player.position = CGPointMake(size.width /2,size.height/2);
        
        _map.player = _player;
        
        [_map addChild:_player];
        [self addChild:_map];
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInNode:_map];
        
        [_map userTouchedPoint:touchPoint];
        
    }
}

- (void)didSimulatePhysics {
    _map.position = CGPointMake(-(_player.position.x-(self.size.width/2)), -(_player.position.y-(self.size.height/2)));
}

@end
