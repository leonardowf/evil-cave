//
//  LWFItemPrototype.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFItemPrototype : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic) NSNumber * baseDamage;
@property (nonatomic) NSNumber * minDamage;
@property (nonatomic) NSNumber * maxDamage;

@property (nonatomic) NSNumber * baseStrength;
@property (nonatomic) NSNumber * minStrength;
@property (nonatomic) NSNumber * maxStrength;

@property (nonatomic) NSNumber * baseHP;
@property (nonatomic) NSNumber * minHP;
@property (nonatomic) NSNumber * maxHP;

@property (nonatomic) NSNumber * baseArmor;
@property (nonatomic) NSNumber * minArmor;
@property (nonatomic) NSNumber * maxArmor;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
