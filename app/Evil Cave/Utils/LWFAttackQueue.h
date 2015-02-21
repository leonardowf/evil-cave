//
//  LWFAttackQueue.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 2/19/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFAttack.h"
#import "LWFAttackable.h"

@interface LWFAttackQueue : LWFAttack

- (void)queue:(id<LWFAttackable>)attacker attacking:(id<LWFAttackable>)attacked;
- (void)attackerAllowedAttackToAttacked:(id<LWFAttackable>)attacked;
- (BOOL)didAttackerAllowedAttackToAttacked:(id<LWFAttackable>)attacked;
- (void)attackedAllowedAttack:(id<LWFAttackable>)attacked;
- (BOOL)didAttackedAllowedAttack:(id<LWFAttackable>)attacked;
- (void)attackerStartAttackToAttacked:(id<LWFAttackable>)attacked;
- (BOOL)didAttackerStartAttackToAttacked:(id<LWFAttackable>)attacked;
- (void)attackedStartAttack:(id<LWFAttackable>)attacked;
- (BOOL)didAttackedStartAttack:(id<LWFAttackable>)attacked;
- (BOOL)allStartedAttack;

@end
