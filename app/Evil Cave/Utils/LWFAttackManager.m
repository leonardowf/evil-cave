//
//  LWFAttackManager.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttackManager.h"

#import "LWFDamageDisplayer.h"

@interface LWFAttackManager () {
    LWFDamageDisplayer *_damagerDisplayer;
    
    id<LWFAttackable> _currentAttackable;
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
    
    
    _currentAttackable = attackable;
    [_damagerDisplayer showString:@"oi" atTile:tile andDelegate:self];
    
    
}

- (void)didShowDamage {
    [_currentAttackable didAttackTile:nil withAttack:nil];
}

@end
