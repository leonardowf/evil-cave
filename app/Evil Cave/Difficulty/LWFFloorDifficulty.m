//
//  LWFLevelDifficulty.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/12/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFFloorDifficulty.h"
#import "LWFCreatureBuilder.h"

@interface LWFFloorDifficulty () {
    LWFCreatureBuilder *_builder;
}

@end

@implementation LWFFloorDifficulty

- (void)buildCreaturesWithBuilder:(LWFCreatureBuilder *)builder {
    _builder = builder;
    
    [self buildFloor1];
}

- (void)buildFloor1 {
    NSMutableArray *creatures = [NSMutableArray array];
    
//    for (NSInteger i = 0; i < self.floor + 1; i++) {
//        LWFCreature *creature = [_builder buildWithType:LWFCreatureTypeRat];
//        [creatures addObject:creature];
//    }
    
//    LWFCreature *poop = [_builder buildWithType:LWFCreatureTypePoopThrowerRat];
    
    LWFCreature *radioctive = [_builder buildWithType:LWFCreatureTypeRadioactiveRat];
    
//    [creatures addObject:poop];
    [creatures addObject:radioctive];
    
    self.creatures = creatures;
}

@end
