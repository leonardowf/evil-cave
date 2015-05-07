//
//  LWFItemsTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LWFNewItem.h"
#import "LWFPotion.h"
#import "LWFGold.h"
#import "LWFEquipment.h"
#import "LWFProjectile.h"

@interface LWFItemsTests : XCTestCase {

}
@end

@implementation LWFItemsTests

- (void)setUp {
    [super setUp];
    
    
    
}

- (void)tearDown {
    [super tearDown];
}

- (void)testItemTypes {
    LWFPotion *potion = [LWFPotion new];
    LWFProjectile *projectile = [LWFProjectile new];
    LWFGold *gold = [LWFGold new];
    LWFEquipment *equipment = [LWFEquipment new];
    
    XCTAssertTrue([potion isPotion]);
    XCTAssertFalse([projectile isPotion]);
    XCTAssertFalse([gold isPotion]);
    XCTAssertFalse([equipment isPotion]);
    
    XCTAssertFalse([potion isProjectile]);
    XCTAssertTrue([projectile isProjectile]);
    XCTAssertFalse([gold isProjectile]);
    XCTAssertFalse([equipment isProjectile]);
    
    XCTAssertFalse([potion isGold]);
    XCTAssertFalse([projectile isGold]);
    XCTAssertTrue([gold isGold]);
    XCTAssertFalse([equipment isGold]);
    
    XCTAssertFalse([potion isEquipment]);
    XCTAssertFalse([projectile isEquipment]);
    XCTAssertFalse([gold isEquipment]);
    XCTAssertTrue([equipment isEquipment]);
    
}

@end
