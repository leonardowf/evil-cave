//
//  LWFDifficultyManager.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/11/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFDifficultyManager.h"
#import "LWFFloorDifficulty.h"
#import "LWFCreature.h"
#import "LWFChestFactory.h"


@interface LWFDifficultyManager () {
    LWFChestFactory *_chestFactory;
}
@end

@implementation LWFDifficultyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _chestFactory = [LWFChestFactory sharedChestFactory];
    }
    return self;
}

- (LWFFloorDifficulty *)getFloorDifficultyForFloor:(NSInteger)floor {
    LWFFloorDifficulty *floorDifficulty = [self floorDifficulty1];
    
    NSInteger mod = floor % 2;
    
    floorDifficulty.numberTilesVertical = floor * 2 * mod + floorDifficulty.numberTilesVertical;
    floorDifficulty.numberTilesHorizontal = floor * 2 * mod + floorDifficulty.numberTilesHorizontal;
    floorDifficulty.floor = floor;
    
    floorDifficulty.chests = [_chestFactory getChestsForFloor:floor];
    
    return floorDifficulty;
}

- (LWFFloorDifficulty *)floorDifficulty1 {
    LWFFloorDifficulty *floorDifficulty = [[LWFFloorDifficulty alloc]init];
    
    floorDifficulty.numberTilesVertical = 13;
    floorDifficulty.numberTilesHorizontal = 13;
    
    return floorDifficulty;
}
@end
