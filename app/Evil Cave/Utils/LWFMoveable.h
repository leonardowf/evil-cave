//
//  LWFMoveable.h
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFTile.h"

@protocol LWFMoveable <NSObject>

- (void)requestMoveToTileAtX:(NSUInteger)x andY:(NSUInteger)y;
- (void)failedToMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)didMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)willMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)moveToTile:(LWFTile *)tile;
- (void)updateCurrentTile:(LWFTile *)currentTile;

@end
