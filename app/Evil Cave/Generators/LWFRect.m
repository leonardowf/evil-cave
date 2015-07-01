//
//  LWFRect.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/28/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFRect.h"

@implementation LWFRect

+ (LWFRect *)rectWithX:(NSInteger)x y:(NSInteger)y width:(NSInteger)width andHeight:(NSInteger)height {
    LWFRect *rect = [[LWFRect alloc]init];
    
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    
    return rect;
}

- (CGFloat)distanceTo:(LWFRect *)other {
    CGRect me = CGRectMake(self.x, self.y, self.width, self.height);
    CGRect otherRect = CGRectMake(other.x, other.y, other.width, other.height);
    
    CGSize distance = CGSizeDistanceBetweenRects(me, otherRect);
    
    
    return distance.width + distance.height;
    
}

- (CGRect)convert {
    return CGRectMake(self.x, self.y, self.width, self.height);
}

CGSize CGSizeDistanceBetweenRects(CGRect rect1, CGRect rect2)
{
    if (CGRectIntersectsRect(rect1, rect2))
    {
        return CGSizeMake(0, 0);
    }
    
    CGRect mostLeft = rect1.origin.x < rect2.origin.x ? rect1 : rect2;
    CGRect mostRight = rect2.origin.x < rect1.origin.x ? rect1 : rect2;
    
    CGFloat xDifference = mostLeft.origin.x == mostRight.origin.x ? 0 : mostRight.origin.x - (mostLeft.origin.x + mostLeft.size.width);
    xDifference = MAX(0, xDifference);
    
    CGRect upper = rect1.origin.y < rect2.origin.y ? rect1 : rect2;
    CGRect lower = rect2.origin.y < rect1.origin.y ? rect1 : rect2;
    
    CGFloat yDifference = upper.origin.y == lower.origin.y ? 0 : lower.origin.y - (upper.origin.y + upper.size.height);
    yDifference = MAX(0, yDifference);
    
    return CGSizeMake(xDifference, yDifference);
}

- (CGPoint)middleCoordinate {
    NSInteger x = self.x + self.width / 2;
    NSInteger y = self.y + self.height / 2;
    
    return CGPointMake(x, y);
}

@end
