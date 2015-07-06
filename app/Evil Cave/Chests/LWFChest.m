//
//  LWFChest.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/3/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

typedef enum : NSUInteger {
    LWFChestStateClosed,
    LWFChestStateOpen
} LWFChestState;

#import "LWFChest.h"

@interface LWFChest () {
    LWFChestState _chestState;
}
@end

@implementation LWFChest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isOpen {
    return _chestState == LWFChestStateOpen;
}

- (BOOL)isClosed {
    return _chestState == LWFChestStateClosed;
}

- (void)open {
    _chestState = LWFChestStateOpen;
}

@end
