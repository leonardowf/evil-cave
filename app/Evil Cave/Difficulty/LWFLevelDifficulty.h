//
//  LWFLevelDifficulty.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/12/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFLevelDifficulty : NSObject

@property (nonatomic, strong) NSArray *creatures;
@property (nonatomic, strong) NSArray *chests;
@property (nonatomic) NSInteger depth;
@property (nonatomic) NSInteger numberTilesVertical;
@property (nonatomic) NSInteger numberTilesHorizontal;

@end
