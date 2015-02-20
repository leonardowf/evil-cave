//
//  LWFAttackQueue.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 2/19/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFAttackQueue.h"
#import "LWFAttackable.h"
#import "LWFAttackQueueCell.h"

@interface LWFAttackQueue () {
    NSMutableArray *_queue;
}

@end

@implementation LWFAttackQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [NSMutableArray array];
    }
    return self;
}

- (void)queue:(id<LWFAttackable>)attacker attacking:(id<LWFAttackable>)attacked {
    LWFAttackQueueCell *attackerControls = [[LWFAttackQueueCell alloc]init];
    LWFAttackQueueCell *attackedControls = [[LWFAttackQueueCell alloc]init];
    
    NSDictionary *queueCell = @{@"attacker": attacker, @"attacked": attacked, @"attacker_controls": attackerControls, @"attacked_controls": attackedControls};
    [_queue addObject:queueCell];
}

- (BOOL)allAllowed {
    for (NSDictionary *dictionary in _queue) {
        NSNumber *allowed = [dictionary objectForKey:@"allowed"];
        
        if ([allowed boolValue] == NO) {
            return NO;
        }
    }
    return YES;
}

- (void)attackerAllowedAttackToAttacked:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackerControls = [queueCell objectForKey:@"attacker_controls"];
    
    attackerControls.allowedAttack = @1;
}

- (void)attackedAllowedAttack:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackerControls = [queueCell objectForKey:@"attacked_controls"];
    
    attackerControls.allowedAttack = @1;
}

- (NSDictionary *)findQueueCellForAttacked:(id<LWFAttackable>)attacked {
    for (NSDictionary *dict in _queue) {
        id<LWFAttackable> searchedAttacked = [dict objectForKey:@"attacked"];
        if (searchedAttacked == attacked) {
            return dict;
        }
    }
    
    return nil;
}

@end
