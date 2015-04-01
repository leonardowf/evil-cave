//
//  LWFPoopThrowerRat.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/31/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPoopThrowerRat.h"

@implementation LWFPoopThrowerRat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spriteImageName = @"poop_thrower_rat";
    }
    return self;
}

- (void)build {
    [super build];
    
}

- (NSArray *)getWalkingFramesAnimation {
    return nil;
}

- (NSArray *)getAttackingFramesAnimation {
    return nil;
}

@end
