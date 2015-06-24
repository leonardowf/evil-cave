//
//  LWFEquips.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFEquips.h"
#import "LWFItemComparison.h"
#import "LWFEquipment.h"

@implementation LWFEquips

- (LWFEquipment *)equip:(LWFEquipment *)equipment {
    LWFEquipment *replacedItem;
    
    if ([equipment isWeapon]) {
        replacedItem = self.weapon;
        self.weapon = equipment;
        return replacedItem;
    }
    
    if ([equipment isArmor]) {
        replacedItem = self.armor;
        self.armor = equipment;
        return replacedItem;
    }
    
    if ([equipment isBoots]) {
        replacedItem = self.boots;
        self.boots = equipment;
        return replacedItem;
    }
    
    if ([equipment isAccessory]) {
        replacedItem = self.accessory;
        self.accessory = equipment;
        return replacedItem;
    }
    
    return nil;
}

- (void)unequip:(LWFEquipment *)equipment {
    if ([equipment isWeapon]) {
        self.weapon = nil;
    }
    
    if ([equipment isArmor]) {
        self.armor = nil;
    }
    
    if ([equipment isBoots]) {
        self.boots = nil;
    }
    
    if ([equipment isAccessory]) {
        self.accessory = nil;
    }
}

- (BOOL)isEquiped:(LWFEquipment *)equipment {
    if (self.weapon == equipment) {
        return YES;
    }
    
    if ([equipment isArmor]) {
        return YES;
    }
    
    if ([equipment isBoots]) {
        return YES;
    }
    
    if ([equipment isAccessory]) {
        return YES;
    }
    
    return NO;
}

- (LWFItemComparison *)compareToRespectiveEquipped:(LWFEquipment *)equipment {
    LWFEquipment *equipmentToCompare = nil;
    
    if ([equipment isWeapon]) {
        equipmentToCompare = self.weapon;
    }
    
    // .... TODO
    return [LWFItemComparison compare:equipment withEquipment:equipmentToCompare];
}

- (LWFItemComparison *)compare:(LWFEquipment *)equipmentSrc toItem:(LWFEquipment *)equipmentDest {
    
    return [LWFItemComparison compare:equipmentSrc withEquipment:equipmentDest];
}

- (NSInteger)totalStrength {
    NSInteger total = [self.weapon.strength integerValue];
    total += [self.armor.strength integerValue];
    total += [self.boots.strength integerValue];
    total += [self.accessory.strength integerValue];
    
    return total;
}

- (NSInteger)totalMinDamage {
    NSInteger total = [self.weapon.lowdamage integerValue];
    total += [self.armor.lowdamage integerValue];
    total += [self.boots.lowdamage integerValue];
    total += [self.accessory.lowdamage integerValue];
    
    return total;
}

- (NSInteger)totalMaxDamage {
    NSInteger total = [self.weapon.highdamage integerValue];
    total += [self.armor.highdamage integerValue];
    total += [self.boots.highdamage integerValue];
    total += [self.accessory.highdamage integerValue];
    
    return total;
}

- (NSInteger)totalArmor {
    NSInteger total = [self.weapon.armor integerValue];
    total += [self.armor.armor integerValue];
    total += [self.boots.armor integerValue];
    total += [self.accessory.armor integerValue];
    
    return total;
}

@end
