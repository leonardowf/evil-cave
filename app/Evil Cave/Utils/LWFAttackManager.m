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

@interface LWFAttackManager () {
    id<LWFAttackable> _currentAttackable;
    
    BOOL _attackedAllowedAttack;
    BOOL _attackerAllowedAttack;
    
    BOOL _attackerDidStartAttack;
    BOOL _attackedDidStartReceivingAttack;
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
    
    // TODO: Adicionar AOE
    
    _attackedAllowedAttack = _attackerAllowedAttack = NO;
    
    LWFCreature *creatureOnTile = tile.creatureOnTile;
    
    _currentAttackable = attackable;
    
    if (creatureOnTile != nil) {
        [creatureOnTile willBeAttackedByAttackable:attackable withAttack:attack completion:^{
            _attackedAllowedAttack = YES;
            [self proceedAttack:attackable target:creatureOnTile attack:attack];
        }];
        
        [attackable willAttackTile:tile withAttack:attack completion:^{
            _attackerAllowedAttack = YES;
            [self proceedAttack:attackable target:creatureOnTile attack:attack];
        }];
    }
}

- (void)proceedAttack:(id<LWFAttackable>)attacker target:(id<LWFAttackable>)target attack:(LWFAttack *)attack {
    if (_attackedAllowedAttack && _attackerAllowedAttack) {
        _attackedDidStartReceivingAttack = _attackerDidStartAttack = NO;
        
        LWFCombatOutput *result = [LWFCombatSystem calculateForAttacker:attacker target:target withAttack:attack];
        
        [attacker attacksAttackable:target withAttack:attack completion:^{
            _attackerDidStartAttack = YES;
            [self attackFinished:attacker target:target attack:attack];
        }];
        
        [target isBeingAttackedBy:attacker withAttack:attack forCombatOutput:result completion:^{
            _attackedDidStartReceivingAttack = YES;
            [self attackFinished:attacker target:target attack:attack];
            
        }];
    }
}

- (void)attackFinished:(id<LWFAttackable>)attacker target:(id<LWFAttackable>)target attack:(LWFAttack *)attack {
    if (_attackedDidStartReceivingAttack && _attackerDidStartAttack) {
        NSLog(@"animação de ataque terminou hue");
        [self didShowDamage];
    }
}

- (void)didShowDamage {
    [_currentAttackable didAttackTile:nil withAttack:nil];
}

@end
