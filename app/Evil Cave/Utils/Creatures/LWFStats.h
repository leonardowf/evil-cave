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

@property NSInteger maxHP;
@property NSInteger actionPoints;
@property NSInteger strength;
@property NSInteger chanceToHit;
@property NSInteger baseArmor;

@property (nonatomic) NSInteger currentHP;
@property (nonatomic) NSInteger currentActions;

@property (nonatomic, strong) id<LWFKillable> killable;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)receivesCombatOutput:(LWFCombatOutput *)combatOutput;
@end
