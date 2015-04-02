//
//  LWFPoopThrowAttack.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/1/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPoopThrowAttack.h"
#import "LWFPointObject.h"

@implementation LWFPoopThrowAttack

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumDamage = 1;
        self.maximumDamage = 1;
    }
    return self;
}

- (NSMutableArray *)range {
    
    //X X X X X
    //X X X X X
    //X X 0 X X
    //X X X X X
    //X X X X X
    
    NSMutableArray *range = [NSMutableArray array];
    
    for (NSInteger i = -2; i <= 2; i++) {
        for (NSInteger j = -2; j <= 2; j++) {
            LWFPointObject *pointObject = [LWFPointObject pointWithX:i andY:j];
            [range addObject:pointObject];
        }
    }
    
    return range;
}

- (NSMutableArray *)affectedRange {
    NSMutableArray *range = [NSMutableArray array];
    
    LWFPointObject *pointObject;
    
    pointObject = [LWFPointObject pointWithX:0 andY:0];
    [range addObject:pointObject];
    
    return range;
}

@end
