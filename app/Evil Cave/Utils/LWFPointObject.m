//
//  LWFPointObject.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/14/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFPointObject.h"

@implementation LWFPointObject

+ (LWFPointObject *)pointWithX:(NSInteger)x andY:(NSInteger)y {
    LWFPointObject *point = [[LWFPointObject alloc]init];
    point.x = x;
    point.y = y;
    
    return point;
}

@end
