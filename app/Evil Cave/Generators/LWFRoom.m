//
//  LWFRoom.m
//  Evil Cave
//
//  Created by Leonardo on 11/17/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFRoom.h"
#import "LWFRandomUtils.h"

@interface LWFRoom () {
    LWFRandomUtils *_randomUtils;
}
@end

@implementation LWFRoom

- (CGPoint)midCoordinate {
    NSInteger midX = ((self.width / 2) + 0.5);
    midX = midX + self.x;
    
    NSUInteger midY = ((self.heigth / 2) + 0.5);
    midY = midY + self.y;
    
    return CGPointMake(midX, midY);
}

@end
