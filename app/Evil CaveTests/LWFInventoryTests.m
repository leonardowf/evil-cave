//
//  LWFInventoryTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/18/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LWFInventory.h"
#import "LWFEquipment.h"
#import "LWFPotion.h"

@interface LWFInventoryTests : XCTestCase {
    LWFInventory *_inventory;
}

@end

@implementation LWFInventoryTests

- (void)setUp {
    [super setUp];
    
    _inventory = [LWFInventory sharedInventory];
}

- (void)tearDown {
    [super tearDown];
    [_inventory clear];
}

- (void)testInventoryIsEmpty {
    XCTAssertTrue([_inventory isEmpty]);
}

- (void)testInventoryNotEmpty {
    LWFEquipment *equipment = [LWFEquipment new];
    equipment.category = @"weapon";
    
    [_inventory takeItem:equipment];
    XCTAssertFalse([_inventory isEmpty]);
    
    [_inventory equip:equipment];
    XCTAssertFalse([_inventory isEmpty]);
}

- (void)testInventoryClearance {
    LWFEquipment *equipment = [[LWFEquipment alloc]init];
    [_inventory takeItem:equipment];
    
    [_inventory clear];
    XCTAssertTrue([_inventory isEmpty]);
}

- (void)testInventoryNotClear {
    LWFEquipment *equipment = [[LWFEquipment alloc]init];
    equipment.category = @"weapon";
    [_inventory takeItem:equipment];
    
    [_inventory equip:equipment];
    XCTAssertFalse([_inventory isEmpty]);
}

- (void)testCanTakeItemShouldReturnNo {
    [self add:STORED_ITEMS_LIMIT];
    LWFEquipment *equipment = [LWFEquipment new];
    equipment.category = @"weapon";
    XCTAssertFalse([_inventory canTakeItem:equipment]);
}

- (void)testCanTakeItemShouldReturnYes {
    [self add:STORED_ITEMS_LIMIT -1];
    LWFEquipment *equipment = [LWFEquipment new];
    equipment.category = @"weapon";
    XCTAssertTrue([_inventory canTakeItem:equipment]);
}

- (void)testCanTakeStackableItemWithEmptyInventory {
    LWFPotion *potion = [LWFPotion new];
    potion.quantity = 1;
    potion.identifier = @"health_potion";
    
    XCTAssertTrue([_inventory canTakeItem:potion]);
}

- (void)testCannotAddStackableItemWithFullOfEquipsInventory {
    [self add:STORED_ITEMS_LIMIT];
    LWFPotion *potion = [LWFPotion new];
    potion.quantity = 1;
    potion.identifier = @"health_potion";
    
    XCTAssertFalse([_inventory canTakeItem:potion]);
}

- (void)testTakeItemDoesNothingIfInventoryFull {
    [self add:STORED_ITEMS_LIMIT];
    
    LWFPotion *potion = [LWFPotion new];
    potion.quantity = 1;
    potion.identifier = @"health_potion";
    
    XCTAssertFalse([_inventory canTakeItem:potion]);
    [_inventory takeItem:potion];
    XCTAssertEqual(_inventory.items.count, STORED_ITEMS_LIMIT);
}

- (void)testIfFindsItemThatCanStack {
    LWFPotion *potion = [LWFPotion new];
    potion.quantity = 1;
    potion.identifier = @"health_potion";
    
    [self add:3];
    [_inventory takeItem:potion];
    
    LWFPotion *potion2 = [LWFPotion new];
    potion2.quantity = 1;
    potion2.identifier = @"health_potion";
    
    LWFNewItem *foundItem = [_inventory findSameKindStackable:potion2];
    
    XCTAssertEqual(foundItem, potion);
}

- (void)testIfDontFindStackableItem {
    LWFPotion *potion = [LWFPotion new];
    potion.quantity = 1;
    potion.identifier = @"health_potion";
    
    [self add:3];
    
    LWFNewItem *foundItem = [_inventory findSameKindStackable:potion];
    
    XCTAssertNil(foundItem);
}

- (void)testCanTakeStackableWithFullInventoryButOneStackable {
    [self add:STORED_ITEMS_LIMIT -1];
    
    LWFPotion *potion = [LWFPotion new];
    potion.quantity = 1;
    potion.identifier = @"health_potion";
    
    [_inventory takeItem:potion];
    
    LWFPotion *potion2 = [LWFPotion new];
    potion2.quantity = 1;
    potion2.identifier = @"health_potion";
    
    XCTAssertTrue([_inventory canTakeItem:potion2]);
}

- (void)testTakeStackableItemWithInventoryWithStackableItem {
    LWFPotion *potion = [LWFPotion new];
    potion.quantity = 1;
    potion.identifier = @"health_potion";
    
    LWFPotion *potion2 = [LWFPotion new];
    potion2.quantity = 1;
    potion2.identifier = @"health_potion";
    
    NSInteger beforeTakeItemTotal = potion.quantity + potion2.quantity;
    
    [_inventory takeItem:potion];
    [_inventory takeItem:potion2];
    
    XCTAssertEqual(potion.quantity, beforeTakeItemTotal);
}

- (void)add:(NSInteger)numberOfEquips {
    for (NSInteger i = 0; i < numberOfEquips; i++) {
        LWFEquipment *equipment = [LWFEquipment new];
        equipment.category = @"weapon";
        [_inventory takeItem:equipment];
    }
}

@end
