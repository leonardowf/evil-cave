//
//  LWFItemPrototype.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFItem;

@interface LWFItemPrototype : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic) NSNumber * baseDamage;
@property (nonatomic) NSNumber * minDamage;
@property (nonatomic) NSNumber * maxDamage;

@property (nonatomic) NSNumber * baseStrength;
@property (nonatomic) NSNumber * minStrength;
@property (nonatomic) NSNumber * maxStrength;

@property (nonatomic) NSNumber * baseHp;
@property (nonatomic) NSNumber * minHp;
@property (nonatomic) NSNumber * maxHp;

@property (nonatomic) NSNumber * baseArmor;
@property (nonatomic) NSNumber * minArmor;
@property (nonatomic) NSNumber * maxArmor;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (LWFItem *)build;
@end
