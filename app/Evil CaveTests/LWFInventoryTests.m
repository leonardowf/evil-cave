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

@end
