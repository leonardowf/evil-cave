//
//  LWFEquipment.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItem.h"

@interface LWFEquipment : LWFItem

@property (nonatomic, strong) NSNumber * lowdamage;
@property (nonatomic, strong) NSNumber * highdamage;
@property (nonatomic, strong) NSNumber * strength;
@property (nonatomic, strong) NSNumber * HP;
@property (nonatomic, strong) NSNumber * armor;

- (BOOL)isWeapon;
- (BOOL)isArmor;
- (BOOL)isAccessory;
- (BOOL)isBoots;

- (NSString *)damageText;
- (NSString *)armorText;
- (NSString *)strengthText;
- (NSString *)hpText;

- (void)calculateForKey:(NSString *)key andPrototype:(LWFItemPrototype *)prototype;

@end
