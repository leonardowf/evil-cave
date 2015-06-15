//
//  LWFInventory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LWFEquipment.h"

@class LWFPlayer;
@class LWFViewController;
@class LWFEquips;
@class LWFNewItem;
@class LWFPotion;

static NSInteger const STORED_ITEMS_LIMIT = 15;

@interface LWFInventory : SKSpriteNode

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) LWFPlayer *player;
@property (nonatomic) NSInteger money;
@property (nonatomic, strong) LWFEquips *equips;

+ (id)sharedInventory;

- (void)show;
- (void)hide;
- (void)hideItemDescriptionIfNeeded;

- (BOOL)canTakeItem:(LWFNewItem *)item;
- (void)takeItem:(LWFNewItem *)item;
- (BOOL)isEquipped:(LWFEquipment *)equipment;

- (void)inject:(LWFViewController *)viewController;
- (BOOL)isOpen;
- (void)equip:(LWFEquipment *)equipment;
- (BOOL)canUnequip:(LWFEquipment *)equipment;
- (void)unequip:(LWFEquipment *)equipment;
- (void)drop:(LWFNewItem *)item;
- (void)clear;
- (BOOL)isEmpty;
- (LWFNewItem *)findSameKindStackable:(LWFNewItem *)item;
- (void)didUsePotion:(LWFPotion *)potion;
- (void)requestThrowItem:(LWFNewItem *)item;


@end
