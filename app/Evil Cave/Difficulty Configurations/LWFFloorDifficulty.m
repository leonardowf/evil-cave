//
//  LWFLevelDifficulty.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/12/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFFloorDifficulty.h"
#import "LWFCreatureBuilder.h"
#import "LWFRatKing.h"
#import "LWFCreatureDeadRequisite.h"

@interface LWFFloorDifficulty () {
    LWFCreatureBuilder *_builder;
}

@end

@implementation LWFFloorDifficulty

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nextFloorRequisites = [NSArray new];
    }
    return self;
}

- (void)buildCreaturesWithBuilder:(LWFCreatureBuilder *)builder {
    _builder = builder;
    
    if (self.floor == 5) {
        [self buildBossRoom];
    } else {
        [self buildFloor1];
    }
    
}

- (void)buildFloor1 {
    NSMutableArray *creatures = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.floor + 2; i++) {
        LWFCreature *creature = [_builder buildWithType:LWFCreatureTypeRat];
        [creatures addObject:creature];
    }
    
    LWFCreature *radioctive = [_builder buildWithType:LWFCreatureTypeRadioactiveRat];
    [creatures addObject:radioctive];
    
    self.creatures = creatures;
}

- (void)buildBossRoom {
    NSMutableArray *creatures = [NSMutableArray array];
    LWFCreature *ratKing = [_builder buildWithType:LWFCreatureTypeRatKing];
    
    [creatures addObject:ratKing];
    self.creatures = creatures;
    
    LWFCreatureDeadRequisite *requisite = [[LWFCreatureDeadRequisite alloc]initWithCreature:ratKing];
    
    self.nextFloorRequisites = [NSArray arrayWithObject:requisite];
}

@end
