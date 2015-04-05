//
//  LWFLogger.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLogger.h"
#import "LWFCreature.h"
#import "LWFHudLogger.h"

@implementation LWFLogger

+ (void)logAttack:(LWFCreature *)creature damage:(NSInteger)damage {
    LWFHudLogger *logger = [LWFHudLogger sharedHudLogger];
    [logger log:@"blabla"];
}

@end
