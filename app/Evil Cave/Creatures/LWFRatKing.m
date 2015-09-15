//
//  LWFRatKing.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 9/14/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFRatKing.h"

@implementation LWFRatKing

- (instancetype)init
{
    self = [super init];
    if (self) {
        // TODO: Trocar o asset
        self.spriteImageName = @"rat";
        self.name = @"Rat King";
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
