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

- (void)attackerAllowedAttackToAttacked:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackerControls = [queueCell objectForKey:@"attacker_controls"];
    
    attackerControls.allowedAttack = @1;
}

- (BOOL)didAttackerAllowedAttackToAttacked:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackerControls = [queueCell objectForKey:@"attacker_controls"];
    
    return [attackerControls.allowedAttack boolValue];
}

- (void)attackedAllowedAttack:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackedControls = [queueCell objectForKey:@"attacked_controls"];
    
    attackedControls.allowedAttack = @1;
}

- (BOOL)didAttackedAllowedAttack:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackedControls = [queueCell objectForKey:@"attacked_controls"];
    
    return [attackedControls.allowedAttack boolValue];
}

- (void)attackerStartAttackToAttacked:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackerControls = [queueCell objectForKey:@"attacker_controls"];
    
    attackerControls.attackStart = @1;
}

- (BOOL)didAttackerStartAttackToAttacked:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackerControls = [queueCell objectForKey:@"attacker_controls"];
    
    return [attackerControls.attackStart boolValue];
}

- (void)attackedStartAttack:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackedControls = [queueCell objectForKey:@"attacked_controls"];
    
    attackedControls.attackStart = @1;
}

- (BOOL)didAttackedStartAttack:(id<LWFAttackable>)attacked {
    NSDictionary *queueCell = [self findQueueCellForAttacked:attacked];
    LWFAttackQueueCell *attackedControls = [queueCell objectForKey:@"attacked_controls"];
    
    return [attackedControls.attackStart boolValue];
}

- (BOOL)allStartedAttack {
    for (NSDictionary *queueCell in _queue) {
        LWFAttackQueueCell *attackerControls = [queueCell objectForKey:@"attacker_controls"];
        LWFAttackQueueCell *attackedControls = [queueCell objectForKey:@"attacked_controls"];
        
        BOOL bothStarted = [attackerControls.attackStart boolValue] && [attackedControls.attackStart boolValue];
        
        if (!bothStarted) {
            return false;
        }
    }
    return YES;
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
