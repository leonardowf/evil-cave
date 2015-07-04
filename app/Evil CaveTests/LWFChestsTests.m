//
//  LWFChestsTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/3/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LWFChest.h"

@interface LWFChestsTests : XCTestCase

@end

@implementation LWFChestsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfChestIsClosed {
    LWFChest *chest = [LWFChest new];
    
    XCTAssertTrue([chest isClosed]);
}

- (void)testIfChestIsOpen {
    LWFChest *chest = [LWFChest new];
    
    [chest open];
    
    XCTAssertTrue([chest isOpen]);
}

@end
