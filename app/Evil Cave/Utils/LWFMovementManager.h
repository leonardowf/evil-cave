//
//  LWFMovementManager.h
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFMoveable.h"

@class LWFTileMap;

@interface LWFMovementManager : NSObject

@property LWFTileMap *tileMap;

- (instancetype)initWithTileMap:(LWFTileMap *)tileMap;
- (void)moveable:(id<LWFMoveable>)moveable requestMoveToTileAtX:(NSUInteger)x andY:(NSUInteger)y;

@end
