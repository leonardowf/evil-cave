//
//  LWFRect.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/28/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFRect : NSObject

@property NSInteger x;
@property NSInteger y;
@property NSInteger width;
@property NSInteger height;

+ (LWFRect *)rectWithX:(NSInteger)x y:(NSInteger)y width:(NSInteger)width andHeight:(NSInteger)height;

- (CGFloat)distanceTo:(LWFRect *)other;
- (CGPoint)middleCoordinate;
@end
