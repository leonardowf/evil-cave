//
//  LWFGeometry.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/9/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGPoint CGPointScale(CGPoint A, double b);
extern CGPoint CGPointAdd(CGPoint a, CGPoint b);
extern CGPoint CGPointSubtract(CGPoint a, CGPoint b);
extern double CGPointCross(CGPoint a, CGPoint b);
extern double CGPointDot(CGPoint a, CGPoint b);
extern double CGPointMagnitude(CGPoint pt);
extern CGPoint CGPointNormalize(CGPoint pt);

extern BOOL BPLineSegmentsIntersect(CGPoint a1, CGPoint a2, CGPoint b1, CGPoint b2);