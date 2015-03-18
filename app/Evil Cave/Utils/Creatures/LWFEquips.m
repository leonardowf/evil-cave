//
//  LWFEquips.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFEquips.h"
#import "LWFItem.h"

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
    return nil;
}

- (LWFItemComparison *)compare:(LWFItem *)itemSrc toItem:(LWFItem *)itemDest {
    return nil;
}

@end
