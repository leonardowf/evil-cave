//
//  LWFAttacksBuilder.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttacksBuilder.h"
#import "LWFMelee.h"
#import "LWFPoopThrowAttack.h"
#import "LWFGameController.h"

@interface LWFAttacksBuilder () {
    LWFGameController *_gameController;
}
@end

@implementation LWFAttacksBuilder

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gameController = [LWFGameController sharedGameController];
    }
    return self;
}

- (NSMutableArray *)attacksForCreatureType:(LWFCreatureType)creatureType {
    NSMutableArray *attacks = nil;
    
    if (creatureType == LWFCreatureTypePoopThrowerRat) {
        return [self poopThrowerRatAttacks];
    } else if (creatureType == LWFCreatureTypeRat) {
        return [self ratAttacks];
    } else if (creatureType == LWFCreatureTypeGoblin) {
        return [self goblinAttacks];
    } else if (creatureType == LWFCreatureTypeRadioactiveRat) {
        return [self radioactiveRatAttacks];
    } else if (creatureType == LWFCreatureTypeWarrior) {
        return [self warriorAttacks];
    } else if (creatureType == LWFCreatureTypeRatKing) {
        return [self ratKingAttacks];
    }
    
    return attacks;
}

- (NSMutableArray *)ratAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

- (NSMutableArray *)poopThrowerRatAttacks {
    LWFPoopThrowAttack *poopThrowAttack = [[LWFPoopThrowAttack alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:poopThrowAttack];
    
    return attacks;
}

- (NSMutableArray *)warriorAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

- (NSMutableArray *)radioactiveRatAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

- (NSMutableArray *)ratKingAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

- (NSMutableArray *)goblinAttacks {
    LWFMelee *melee = [[LWFMelee alloc]init];
    
    NSMutableArray *attacks = [NSMutableArray array];
    [attacks addObject:melee];
    
    return attacks;
}

@end
