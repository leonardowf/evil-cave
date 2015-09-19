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
        self.spriteImageName = @"rat_king";
        self.name = @"Rat King";
    }
    return self;
}

- (void)build {
    [super build];
}

- (void)didBuild {
    self.size = CGSizeMake(self.size.width + 10, self.size.height + 10);
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
