//
//  LWFTurnList.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/26/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFTurnList.h"
#import "LWFPlayer.h"
#import "LWFMap.h"

@implementation LWFTurnList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.creatures = [NSMutableArray array];
    }
    return self;
}

- (void)creatureFinishedTurn:(LWFCreature *)creature {
    LWFCreature *nextCreature = [self creatureAfterThis:creature];
    
    [self processTurnForCreature:nextCreature];
}

- (LWFCreature *)creatureAfterThis:(LWFCreature *)creature {
    NSUInteger creatureIndex = [self.creatures indexOfObject:creature];
    creatureIndex++;
    
    if (creatureIndex == [self.creatures count]) {
        creatureIndex = 0;
        [self.map newTurnCycleStarted];
    }
    
    LWFCreature *creatureAfter = [self.creatures objectAtIndex:creatureIndex];
    return creatureAfter;
}

- (void)processTurnForCreature:(LWFCreature *)creature {
    Class playerClass = [LWFPlayer class];
    
    [creature processTurn];
}

@end
