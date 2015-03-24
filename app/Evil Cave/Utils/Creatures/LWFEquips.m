//
//  LWFEquips.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFEquips.h"
#import "LWFItem.h"
#import "LWFItemComparison.h"

@implementation LWFEquips

- (LWFItem *)equip:(LWFItem *)item {
    LWFItem *replacedItem;
    
    if ([item isWeapon]) {
        replacedItem = self.weapon;
        self.weapon = item;
        return replacedItem;
    }
    
    if ([item isArmor]) {
        replacedItem = self.armor;
        self.armor = item;
        return replacedItem;
    }
    
    if ([item isBoots]) {
        replacedItem = self.boots;
        self.boots = item;
        return replacedItem;
    }
    
    if ([item isAccessory]) {
        replacedItem = self.accessory;
        self.accessory = item;
        return replacedItem;
    }
    
    return nil;
}

- (LWFItemComparison *)compareToRespectiveEquipped:(LWFItem *)item {
    LWFItem *itemToCompare = nil;
    
    if (item.isWeapon) {
        itemToCompare = self.weapon;
    }
    
    // ....
    
    return [LWFItemComparison compare:item withItem:itemToCompare];
}

- (LWFItemComparison *)compare:(LWFItem *)itemSrc toItem:(LWFItem *)itemDest {
    return [LWFItemComparison compare:itemSrc withItem:itemDest];
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
