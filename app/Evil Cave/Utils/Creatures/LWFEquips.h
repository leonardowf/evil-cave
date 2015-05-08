//
//  LWFEquips.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFEquipment;
@class LWFItemComparison;

@interface LWFEquips : NSObject

@property (nonatomic, strong) LWFEquipment *weapon;
@property (nonatomic, strong) LWFEquipment *armor;
@property (nonatomic, strong) LWFEquipment *boots;
@property (nonatomic, strong) LWFEquipment *accessory;

- (LWFEquipment *)equip:(LWFEquipment *)equipment;
- (void)unequip:(LWFEquipment *)equipment;
- (LWFItemComparison *)compareToRespectiveEquipped:(LWFEquipment *)item;
- (LWFItemComparison *)compare:(LWFEquipment *)equipmentSrc toItem:(LWFEquipment *)equipmentDest;

- (NSInteger)totalStrength;
- (NSInteger)totalMinDamage;
- (NSInteger)totalMaxDamage;
- (NSInteger)totalArmor;
- (BOOL)isEquiped:(LWFEquipment *)item;

@end
