//
//  LWFPotionsTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "LWFInventory.h"
#import "LWFPotion.h"

@interface LWFPotionsTests : XCTestCase {
    LWFInventory *_inventory;
}
@end

@implementation LWFPotionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _inventory = [LWFInventory sharedInventory];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    [_inventory clear];
}

- (void)testInventoryEmpty {
    XCTAssertEqual(_inventory.items.count, 0);
}

- (void)testIfPotionAddedToInventory {
    LWFPotion *potion = [LWFPotion new];
    [_inventory.items addObject:potion];
    XCTAssertEqual(_inventory.items.count, 1);
}

@end
