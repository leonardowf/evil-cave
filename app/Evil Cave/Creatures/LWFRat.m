//
//  LWFRat.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/23/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFRat.h"

@implementation LWFRat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spriteImageName = @"rat";
        self.name = @"Rat";
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

- (NSString *)getSoundName:(LWFSoundType)soundType {
    return @"ratHit.wav";
}


@end
