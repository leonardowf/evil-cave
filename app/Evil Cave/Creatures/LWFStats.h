//
//  LWFStats.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFKillable.h"

@class LWFCombatOutput;

@interface LWFStats : NSObject

@property (nonatomic) NSInteger maxHP;
@property (nonatomic) NSInteger actionPoints;
@property (nonatomic) NSInteger strength;
@property (nonatomic) NSInteger chanceToHit;
@property (nonatomic) NSInteger baseArmor;
@property (nonatomic) NSInteger chanceToEvade;

@property (nonatomic) NSInteger currentHP;
@property (nonatomic) NSInteger currentActions;

@property (nonatomic, strong) id<LWFKillable> killable;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
                      andKilladble:(id<LWFKillable>) killable;
- (void)receivesCombatOutput:(LWFCombatOutput *)combatOutput;
- (void)reloadStats;

@end
