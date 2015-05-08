//
//  LWFItemPrototype.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFNewItem;

@interface LWFItemPrototype : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic) NSNumber * baseLowdamage;
@property (nonatomic) NSNumber * minLowdamage;
@property (nonatomic) NSNumber * maxLowdamage;

@property (nonatomic) NSNumber * baseHighdamage;
@property (nonatomic) NSNumber * minHighdamage;
@property (nonatomic) NSNumber * maxHighdamage;

@property (nonatomic) NSNumber * baseStrength;
@property (nonatomic) NSNumber * minStrength;
@property (nonatomic) NSNumber * maxStrength;

@property (nonatomic) NSNumber * baseHp;
@property (nonatomic) NSNumber * minHp;
@property (nonatomic) NSNumber * maxHp;

@property (nonatomic) NSNumber * baseArmor;
@property (nonatomic) NSNumber * minArmor;
@property (nonatomic) NSNumber * maxArmor;

@property(nonatomic) NSNumber *atlas;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
