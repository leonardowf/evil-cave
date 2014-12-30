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

+ (LWFPointObject *)point:(LWFPointObject *)point1 plus:(LWFPointObject *)point2 {
    int x = point1.x + point2.x;
    int y = point1.y + point2.y;
    
    return [LWFPointObject pointWithX:x andY:y];
}

+ (LWFPointObject *)point:(LWFPointObject *)point1 minus:(LWFPointObject *)point2 {
    int x = point1.x - point2.x;
    int y = point1.y - point2.y;
    
    return [LWFPointObject pointWithX:x andY:y];
}


+ (LWFPointObject *)pointWithString:(NSString *)pointRepresentation {
    NSArray *coordinates = [pointRepresentation componentsSeparatedByString:@";"];
    
    NSString *x = coordinates[0];
    NSString *y = coordinates[1];
    
    return [LWFPointObject pointWithX:[x intValue] andY:[y intValue]];
}

- (NSString *)toString {
    return [NSString stringWithFormat:@"%d;%d", self.x, self.y];
}

- (CGFloat)distanceTo:(LWFPointObject *)other {
    CGFloat result = sqrt(self.x*other.x + self.y*other.y);
    
    return result;
}

- (BOOL)isItFuckingNear:(LWFPointObject *)other {
    int x = self.x - other.x;
    
    int y = self.y - other.y;
    
    if (x < 0) {
        x = -1 * x;
    }
    
    if (y < 0) {
        y = -1 * y;
    }
    
    return (x == 1 || y == 1);
}



@end
