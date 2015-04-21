//
//  LWFDifficultyManager.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/11/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFDifficultyManager.h"
#import "LWFFloorDifficulty.h"
#import "LWFCreatureBuilder.h"
#import "LWFCreature.h"

@interface LWFDifficultyManager () {
    LWFCreatureBuilder *_creatureBuilder;
}
@end

@implementation LWFDifficultyManager

- (instancetype)initWithCreatureBuilder:(LWFCreatureBuilder *)creatureBuilder
{
    self = [super init];
    if (self) {
        _creatureBuilder = creatureBuilder;
    }
    return self;
}


- (LWFFloorDifficulty *)getFloorDifficultyForFloor:(NSInteger)floor {
    return [self floorDifficulty1];
}

- (LWFFloorDifficulty *)floorDifficulty1 {
    LWFFloorDifficulty *floorDifficulty = [[LWFFloorDifficulty alloc]init];
    
    floorDifficulty.numberTilesVertical = 13;
    floorDifficulty.numberTilesHorizontal = 13;
    floorDifficulty.floor = 1;
    
    return floorDifficulty;
}
@end
