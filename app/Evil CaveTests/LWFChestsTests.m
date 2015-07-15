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
    
    XCTAssertNotNil(chests);
}

- (void)testIfFactoryBringsBiggestFloorChestChance {
    NSMutableArray *chestChances = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 10; i++) {
        LWFChestChance *chestChance = [LWFChestChance new];
        chestChance.floor = i;
        [chestChances addObject:chestChance];
    }
    
    _chestFactory.chestChances = chestChances;
    
    LWFChestChance *chestChance = [_chestFactory findChestChanceForFloor:chestChances.count + 1];
    
    LWFChestChance *lastChestChance = (LWFChestChance *)chestChances.lastObject;
    
    XCTAssertEqual(chestChance.floor, lastChestChance.floor);
}

- (void)testIfFactoryBringsBiggestMiddleFloorChestChance {
    NSMutableArray *chestChances = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 10; i++) {
        if (i == 5) {
            continue;
        }
        
        LWFChestChance *chestChance = [LWFChestChance new];
        chestChance.floor = i;
        [chestChances addObject:chestChance];
    }
    
    _chestFactory.chestChances = chestChances;
    
    LWFChestChance *chestChance = [_chestFactory findChestChanceForFloor:5];
    
    XCTAssertEqual(chestChance.floor, 4);
}

- (void)testIfFactoryBringsCorrectFloor {
    NSMutableArray *chestChances = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 10; i++) {
        LWFChestChance *chestChance = [LWFChestChance new];
        chestChance.floor = i;
        [chestChances addObject:chestChance];
    }
    
    _chestFactory.chestChances = chestChances;
    
    LWFChestChance *chestChance = [_chestFactory findChestChanceForFloor:5];
    LWFChestChance *correctChest = chestChances[4];
    
    
    XCTAssertEqual(chestChance.floor, correctChest.floor);
}

@end
