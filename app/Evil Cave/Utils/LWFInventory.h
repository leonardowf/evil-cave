//
//  LWFInventory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class LWFPlayer;

@interface LWFInventory : SKSpriteNode

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) LWFPlayer *player;
 
+ (id)sharedInventory;

- (void)show;
- (void)hide;

@end