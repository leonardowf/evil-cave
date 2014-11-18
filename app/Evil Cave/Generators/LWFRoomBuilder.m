//
//  LWFRoomBuilder.m
//  Evil Cave
//
//  Created by Leonardo on 11/17/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFRoomBuilder.h"
#import "LWFRoom.h"
#include "LWFRandomUtils.h"

@interface LWFRoomBuilder () {
    LWFRandomUtils *_randomUtils;
}
@end

@implementation LWFRoomBuilder

- (instancetype)initWithMinWidth:(NSUInteger)minWidth
                        maxWidth:(NSUInteger)maxWidth
                       minHeigth:(NSUInteger)minHeigth
                    andMaxHeigth:(NSUInteger)maxHeigth
{
    self = [super init];
    if (self) {
        _randomUtils = [[LWFRandomUtils alloc]init];
        
        _minWidth = minWidth;
        _maxWidth = maxWidth;
        _minHeigth = minHeigth;
        _maxHeigth = maxHeigth;
    }
    return self;
}

- (LWFRoom *)build {
    LWFRoom *room = [[LWFRoom alloc]init];
    
    room.heigth = [_randomUtils randomIntegerBetween:self.minHeigth and:self.maxHeigth];
    room.width = [_randomUtils randomIntegerBetween:self.minWidth and:self.maxWidth];
    
    return room;
}

@end
