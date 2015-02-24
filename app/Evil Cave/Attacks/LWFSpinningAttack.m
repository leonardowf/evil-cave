//
//  LWFSpinningAttack.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 2/13/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFSpinningAttack.h"
#import "LWFPointObject.h"

@implementation LWFSpinningAttack

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumDamage = 10;
        self.maximumDamage = 30;
    }
    return self;
}

- (NSMutableArray *)affectedRange {
    // (-1, 1)( 0, 1)( 1, 1)
    // (-1, 0)( 0, 0)( 1, 0)
    // (-1,-1)( 0,-1)( 1,-1)
    
    NSMutableArray *range = [NSMutableArray array];
    
    LWFPointObject *pointObject;
    
    pointObject = [LWFPointObject pointWithX:-1 andY:1];
    [range addObject:pointObject];
    pointObject = [LWFPointObject pointWithX:0 andY:1];
    [range addObject:pointObject];
    pointObject = [LWFPointObject pointWithX:1 andY:1];
    [range addObject:pointObject];
    pointObject = [LWFPointObject pointWithX:-1 andY:0];
    [range addObject:pointObject];
    pointObject = [LWFPointObject pointWithX:1 andY:0];
    [range addObject:pointObject];
    pointObject = [LWFPointObject pointWithX:-1 andY:-1];
    [range addObject:pointObject];
    pointObject = [LWFPointObject pointWithX:0 andY:-1];
    [range addObject:pointObject];
    pointObject = [LWFPointObject pointWithX:1 andY:-1];
    [range addObject:pointObject];
    
    return range;
}

- (NSMutableArray *)range {
    NSMutableArray *range = [NSMutableArray array];
    
    LWFPointObject *pointObject;
    
    pointObject = [LWFPointObject pointWithX:0 andY:0];
    [range addObject:pointObject];
    
    return range;
}

@end
