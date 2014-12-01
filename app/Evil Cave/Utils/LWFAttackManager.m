//
//  LWFAttackManager.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttackManager.h"

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
    
}

@end
