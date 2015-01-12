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

- (void)didMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)willMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y;
- (void)moveToTile:(LWFTile *)tile completion:(void(^)(void))someBlock;
- (void)updateCurrentTile:(LWFTile *)currentTile;
- (void)moveableToTile:(LWFTile *)tile;
- (void)startWalkingAnimation:(void(^)(void))someBlock;
- (NSArray *)getWalkingFramesAnimation;

- (BOOL)shouldFinishTurnOnFailedMovement;
- (void)notifyMovementFailure;

@end
