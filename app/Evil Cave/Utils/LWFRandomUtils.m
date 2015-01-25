//
//  LWFRandomUtils.m
//  Evil Cave
//
//  Created by Leonardo on 11/17/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFRandomUtils.h"

@implementation LWFRandomUtils

- (instancetype)init
{
    self = [super init];
    if (self) {
        srandom(0);
    }
    return self;
}

- (CGFloat)randomNumberBetween0and1 {
    return random() / (float)0x7fffffff;
}

- (NSInteger)randomIntegerBetween:(NSInteger)low and:(NSInteger)high {
    if (high == low) {
        return high;
    }
    
    
    int rndValue = low + arc4random() % (high - low);
    return rndValue;
}

- (NSNumber *)randomNumberBetween:(NSNumber *)low and:(NSNumber *)high {
    NSInteger intLow = [low integerValue];
    NSInteger intHigh = [high integerValue];
    
    NSInteger r = [self randomIntegerBetween:intLow and:intHigh];
    
    return [NSNumber numberWithInteger:r];
}
@end
