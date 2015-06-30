//
//  LWFCaveGeneratorResult.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/29/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFRect;

@interface LWFCaveGeneratorResult : NSObject

@property (nonatomic, strong) NSMutableArray *stage;

@property (nonatomic, strong) LWFRect *startingRoom;
@property (nonatomic, strong) LWFRect *endingRoom;

@end
