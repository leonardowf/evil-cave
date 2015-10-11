//
//  LWFCreatureDeadRequisite.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFCreatureDeadRequisite.h"
#import "LWFCreature.h"

@implementation LWFCreatureDeadRequisite

- (instancetype)initWithCreature:(LWFCreature *)creature
{
    self = [super init];
    if (self) {
        self.creature = creature;
    }
    return self;
}

- (BOOL)isMet {
    [super isMet];
    
    if ([self.creature isDead]) {
        return true;
    }
    
    return false;
}

@end
