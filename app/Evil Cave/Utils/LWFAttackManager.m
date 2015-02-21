//
//  LWFAttackManager.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttackManager.h"

#import "LWFTile.h"
#import "LWFCreature.h"
#import "LWFCombatSystem.h"
#import "LWFCombatOutput.h"
#import "LWFAttackQueue.h"

@interface LWFAttackManager () {
    id<LWFAttackable> _currentAttackable;
    
    LWFAttackQueue *_attackQueue;
}

@end

@implementation LWFAttackManager

- (instancetype)initWithTileMap:(LWFTileMap *)tileMap
{
    self = [super init];
    if (self) {
        self.tileMap = tileMap;
    }
    return self;
}

- (void)attackable:(id<LWFAttackable>)attackable
requestedAttackToTile:(LWFTile *)tile
        withAttack:(LWFAttack *)attack {
    
    _attackQueue = [[LWFAttackQueue alloc]init];
    
    NSArray *creaturesAffected = [attack creaturesInAffectedRangeFromTile:tile];
    
    for (LWFCreature *creature in creaturesAffected) {
        [_attackQueue queue:attackable attacking:creature];
        
        _currentAttackable = attackable;
        
        [creature willBeAttackedByAttackable:attackable withAttack:attack completion:^{
            [_attackQueue attackedAllowedAttack:creature];
            [self proceedAttack:attackable target:creature attack:attack];
        }];
        
        [attackable willAttackTile:tile withAttack:attack completion:^{
            [_attackQueue attackerAllowedAttackToAttacked:creature];
            [self proceedAttack:attackable target:creature attack:attack];
        }];
    }
}

- (void)proceedAttack:(id<LWFAttackable>)attacker target:(id<LWFAttackable>)target attack:(LWFAttack *)attack {
    
    BOOL canProceedAttack = [_attackQueue didAttackedAllowedAttack:target] && [_attackQueue didAttackerAllowedAttackToAttacked:target];
    
    if (canProceedAttack) {
        
        LWFCombatOutput *result = [LWFCombatSystem calculateForAttacker:attacker target:target withAttack:attack];
        
        [attacker attacksAttackable:target withAttack:attack completion:^{
            [_attackQueue attackerStartAttackToAttacked:target];
            [self attackFinished:attacker target:target attack:attack];
        }];
        
        [target isBeingAttackedBy:attacker withAttack:attack forCombatOutput:result completion:^{
            [_attackQueue attackedStartAttack:target];
            [self attackFinished:attacker target:target attack:attack];
            
        }];
    }
}

- (void)attackFinished:(id<LWFAttackable>)attacker target:(id<LWFAttackable>)target attack:(LWFAttack *)attack {
    if ([_attackQueue allStartedAttack]) {
        [self didShowDamage];
    }
}

- (void)didShowDamage {
    [_currentAttackable didAttackTile:nil withAttack:nil];
}

@end
