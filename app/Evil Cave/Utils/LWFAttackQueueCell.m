//
//  LWFAttackQueueCell.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 2/19/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFAttackQueueCell.h"

@implementation LWFAttackQueueCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allowedAttack = @0;
        self.attackStart = @0;
    }
    return self;
}

@end
