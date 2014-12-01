//
//  LWFAttackManager.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFAttackable.h"

@class LWFTileMap;
@class LWFTile;
@class LWFCreature;

@interface LWFAttackManager : NSObject

@property (nonatomic, strong) LWFTileMap *tileMap;

- (instancetype)initWithTileMap:(LWFTileMap *)tileMap;

- (void)attackable:(id<LWFAttackable>)attackable
requestedAttackToTile:(LWFTile *)tile
        withAttack:(LWFAttack *)attack;

@end
