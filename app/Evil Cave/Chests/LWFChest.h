//
//  LWFChest.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/3/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class LWFTile;

@interface LWFChest : SKSpriteNode

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) LWFTile *tile;

- (BOOL)isOpen;
- (BOOL)isClosed;
- (void)open;
@end
