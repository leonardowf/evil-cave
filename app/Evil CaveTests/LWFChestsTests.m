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
#import "LWFChestFactory.h"
#import "LWFChestChance.h"

@interface LWFChestsTests : XCTestCase {
    LWFChestFactory *_chestFactory;
}

@end

@implementation LWFChestsTests

+ (void)setUp {
    [super setUp];
}

- (void)setUp {
    [super setUp];
    _chestFactory = [LWFChestFactory sharedChestFactory];
}

- (void)tearDown {
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

- (void)testIfChestChanceNeverRespawnChest {
    NSDictionary *chestChanceDictionary = @{@"quantity": @1,
                                            @"chance": @100,
                                            @"floor": @1};
    LWFChestChance *chestChance = [[LWFChestChance alloc]
                                   initWithDictionary:chestChanceDictionary];
    NSInteger amountRespawned = [chestChance amountRespawned];
    
    XCTAssertEqual(amountRespawned, [[chestChanceDictionary objectForKey:@"quantity"] integerValue]);
}

- (void)testIfChestChanceAlwaysRespawnChest {
    NSDictionary *chestChanceDictionary = @{@"quantity": @1,
                                            @"chance": @0,
                                            @"floor": @1};
    LWFChestChance *chestChance = [[LWFChestChance alloc]
                                   initWithDictionary:chestChanceDictionary];
    NSInteger amountRespawned = [chestChance amountRespawned];
    
    XCTAssertEqual(amountRespawned, 0);
}

- (void)testIfFactoryBringsNotNil {
    NSArray *chests = [_chestFactory getChestsForFloor:1];
}

@end
