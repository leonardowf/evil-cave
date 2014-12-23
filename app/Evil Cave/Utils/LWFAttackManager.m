//
//  LWFAttackManager.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttackManager.h"

#import "LWFDamageDisplayer.h"
#import "LWFTile.h"
#import "LWFCreature.h"
#import "LWFCombatSystem.h"

@interface LWFAttackManager () {
    LWFDamageDisplayer *_damagerDisplayer;
    
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
        _damagerDisplayer = [LWFDamageDisplayer sharedLWFDamageDisplayer];
    }
    return self;
}

- (void)attackable:(id<LWFAttackable>)attackable
requestedAttackToTile:(LWFTile *)tile
        withAttack:(LWFAttack *)attack {
    
    // TODO: Adicionar AOE
    
    _attackedAllowedAttack = _attackerAllowedAttack = NO;
    
    LWFCreature *creatureOnTile = tile.creatureOnTile;
    
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
    
    _currentAttackable = attackable;
    [_damagerDisplayer showString:@"oi" atTile:tile andDelegate:self];
}

- (void)proceedAttack:(id<LWFAttackable>)attacker target:(id<LWFAttackable>)target attack:(LWFAttack *)attack {
    if (_attackedAllowedAttack && _attackerAllowedAttack) {
        _attackedDidStartReceivingAttack = _attackerDidStartAttack = NO;
        
        [attacker attacksAttackable:target withAttack:attack completion:^{
            _attackerDidStartAttack = YES;
            [self combatOutputForAttacker:attacker target:target attack:attack];
        }];
        
        [target isBeingAttackedBy:attacker withAttack:attack completion:^{
            _attackedDidStartReceivingAttack = YES;
            [self combatOutputForAttacker:attacker target:target attack:attack];
            
        }];
    }
}

- (void)combatOutputForAttacker:(id<LWFAttackable>)attacker target:(id<LWFAttackable>)target attack:(LWFAttack *)attack {
    if (_attackedDidStartReceivingAttack && _attackerDidStartAttack) {
        NSLog(@"animação de ataque terminou hue");
        LWFCombatOutput *result = [LWFCombatSystem calculateForAttacker:attacker target:target];
        
        
    }
}

- (void)didShowDamage {
    [_currentAttackable didAttackTile:nil withAttack:nil];
}

@end
