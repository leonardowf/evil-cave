//
//  LWFCombatOutput.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCombatOutput.h"

@implementation LWFCombatOutput

- (NSString *)getDamageString {
    return [NSString stringWithFormat:@"%d", self.damage];
}

@end
