//
//  LWFTurnList.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/26/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFTurnList.h"

@implementation LWFTurnList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.creatures = [NSMutableArray array];
    }
    return self;
}

@end
