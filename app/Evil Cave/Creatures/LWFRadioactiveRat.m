//
//  LWFRadioactiveRat.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFRadioactiveRat.h"

@implementation LWFRadioactiveRat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spriteImageName = @"radioactive_rat";
        self.name = @"Radioactive Rat";
    }
    return self;
}

- (void)build {
    [super build];
}

- (NSArray *)getDyingFramesAnimation {
    return nil;
}

- (NSArray *)getWalkingFramesAnimation {
    return nil;
}

- (NSArray *)getAttackingFramesAnimation {
    return nil;
}

@end
