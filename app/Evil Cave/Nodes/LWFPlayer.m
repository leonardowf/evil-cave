//
//  LWFPlayer.m
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFPlayer.h"
#import "LWFTile.h"
#import "LWFMap.h"
#import "LWFTurnList.h"

@implementation LWFPlayer

- (void)didMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    [self.map playerMoved];
    
    [self.turnList creatureFinishedTurn:self];
}

@end
