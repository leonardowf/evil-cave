//
//  LWFPlayer.m
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFPlayer.h"
#import "LWFTile.h"

@implementation LWFPlayer

- (void)moveToTile:(LWFTile *)tile {
    SKAction *moveAction = [SKAction moveTo:tile.position duration:0.2];
    [self runAction: moveAction];
}

@end
