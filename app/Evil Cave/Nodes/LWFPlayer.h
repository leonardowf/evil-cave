//
//  LWFPlayer.h
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class LWFTile;

@interface LWFPlayer : SKSpriteNode

- (void)moveToTile:(LWFTile *)tile;

@end
