//
//  LWFAttackable.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

typedef enum : NSUInteger {
    FailedAttackReasonTODO1,
    FailedAttackReasonTODO2,
    FailedAttackReasonTODO3,
} FailedAttackReason;

#import <Foundation/Foundation.h>

@class LWFTile;
@class LWFAttack;
@class LWFStats;
@class LWFEquips;
@class LWFCombatOutput;

@protocol LWFAttackable <NSObject>

- (void)requestAttackToTile:(LWFTile *)tile
                 withAttack:(LWFAttack *)attack;

- (void)willAttackTile:(LWFTile *)tile
            withAttack:(LWFAttack *)attack completion:(void(^)(void))someBlock;

- (void)willBeAttackedByAttackable:(id<LWFAttackable>)attacker
                        withAttack:(LWFAttack *)attack completion:(void(^)(void))someBlock;

- (void)attacksAttackable:(id<LWFAttackable>)target
               withAttack:(LWFAttack *)attack
               completion:(void(^)(void))someBlock;

- (void)isBeingAttackedBy:(id<LWFAttackable>)attacker
               withAttack:(LWFAttack *)attack
          forCombatOutput:(LWFCombatOutput *)combatOutput
               completion:(void(^)(void))someBlock;

- (void)didAttackTile:(LWFTile *)tile
           withAttack:(LWFAttack *)attack;

- (void)failedToAttackTile:(LWFTile *)tile
                withAttack:(LWFAttack *)attack
                   because:(FailedAttackReason)reason;

- (LWFStats *)getStats;
- (LWFEquips *)getEquips;
- (NSArray *)getAttackingFramesAnimation;

@end
