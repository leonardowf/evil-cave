//
//  LWFStats.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFStats : NSObject

@property NSUInteger maxHP;
@property NSUInteger actionPoints;
@property NSUInteger strength;
@property NSUInteger chanceToHit;
@property NSUInteger baseArmor;

@property (nonatomic) NSUInteger currentHP;
@property (nonatomic) NSUInteger currentActions;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
