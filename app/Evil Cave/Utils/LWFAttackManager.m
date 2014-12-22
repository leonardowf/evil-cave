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

@interface LWFAttackManager () {
    LWFDamageDisplayer *_damagerDisplayer;
    
    id<LWFAttackable> _currentAttackable;
    
    BOOL _attackedAllowedAttack;
    BOOL _attackerAllowedAttack;
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
    
    _attackedAllowedAttack = _attackerAllowedAttack = NO;
    
    LWFCreature *creatureOnTile = tile.creatureOnTile;
    
    if (creatureOnTile != nil) {
        [creatureOnTile willBeAttackedByAttackable:attackable withAttack:attack completion:^{
            _attackedAllowedAttack = YES;
            [self proceedAttack];
        }];
        
        [attackable willAttackTile:tile withAttack:attack completion:^{
            _attackerAllowedAttack = YES;
            [self proceedAttack];
        }];
    }
    
    
    _currentAttackable = attackable;
    [_damagerDisplayer showString:@"oi" atTile:tile andDelegate:self];
    
    
}

- (void)proceedAttack {
    if (_attackedAllowedAttack && _attackerAllowedAttack) {
        NSLog(@"o attaque pode continuar");
    }
    
}

- (void)didShowDamage {
    [_currentAttackable didAttackTile:nil withAttack:nil];
}

@end
