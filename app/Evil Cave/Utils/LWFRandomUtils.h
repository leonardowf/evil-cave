//
//  LWFRandomUtils.h
//  Evil Cave
//
//  Created by Leonardo on 11/17/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFRandomUtils : NSObject

- (NSInteger)randomIntegerBetween:(NSInteger)low and:(NSInteger)high;
- (CGFloat) randomNumberBetween0and1;
- (NSNumber *)randomNumberBetween:(NSNumber *)low and:(NSNumber *)high;
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber;

@end
