//
//  LWFModelGrid.m
//  Evil Cave
//
//  Created by Leonardo on 11/19/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFModelGrid.h"

@implementation LWFModelGrid

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rooms = [NSMutableArray array];
        self.model = [NSMutableArray array];
    }
    return self;
}

@end
