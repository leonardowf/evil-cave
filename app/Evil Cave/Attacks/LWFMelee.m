//
//  LWFMelee.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFMelee.h"
#import "LWFTile.h"
#import "LWFTileMap.h"
#import "LWFPointObject.h"

@implementation LWFMelee

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumDamage = 1;
        self.maximumDamage = 5;
    }
    return self;
}

- (NSMutableArray *)range {
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

@end
