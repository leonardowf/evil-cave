//
//  LWFDifficultyManager.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/11/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFLevelDifficulty;

@interface LWFDifficultyManager : NSObject

@property (nonatomic) NSInteger currentDepth;

- (LWFLevelDifficulty *)getLevelDifficulty;

@end
