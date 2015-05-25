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
#import "LWFItemPrototype.h"
#import "LWFItemFactory.h"

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

- (void)testIfPotionIsUsable {
    LWFPotion *potion = [LWFPotion new];
    
    XCTAssertTrue([potion isUsable]);
}

- (void)testIfEquipIsNotUsable {
    LWFEquipment *potion = [LWFEquipment new];
    
    XCTAssertFalse([potion isUsable]);
}

- (void)testEquipmentGeneration {
    LWFItemPrototype *equipmentPrototype = [LWFItemPrototype new];
    equipmentPrototype.category = @"armor";
    
    LWFItemFactory *itemFactory = [LWFItemFactory new];
    LWFNewItem *item = [itemFactory manufactureWithItemPrototype:equipmentPrototype];

    XCTAssertTrue([item isEquipment]);
}

- (void)testStackOfPotionsOfDifferentTypes {
    LWFPotion *healthPotion = [LWFPotion new];
    healthPotion.identifier = @"health_potion";
    healthPotion.quantity = 1;
    
    LWFPotion *poisonPotion = [LWFPotion new];
    poisonPotion.identifier = @"poison_potion";
    poisonPotion.quantity = 1;
    
    XCTAssertFalse([healthPotion canStackWith:poisonPotion]);
}

- (void)testStackOfPotionsOfSameTypes {
    LWFPotion *healthPotion = [LWFPotion new];
    healthPotion.identifier = @"health_potion";
    healthPotion.quantity = 1;
    
    LWFPotion *healthPotion2 = [LWFPotion new];
    healthPotion2.identifier = @"health_potion";
    healthPotion2.quantity = 1;
    
    XCTAssertTrue([healthPotion canStackWith:healthPotion2]);
}

- (void)testStackOfPotions {
    LWFPotion *healthPotion = [LWFPotion new];
    healthPotion.identifier = @"health_potion";
    healthPotion.quantity = 1;
    
    LWFPotion *healthPotion2 = [LWFPotion new];
    healthPotion2.identifier = @"health_potion";
    healthPotion2.quantity = 1;
    
    NSInteger totalQuantityBeforeStack = healthPotion.quantity + healthPotion2.quantity;
    
    LWFNewItem *returnedItem = [healthPotion stackWithItem:healthPotion2];
    
    // multiple assertions are bad?
    
    XCTAssertEqual(healthPotion.quantity, totalQuantityBeforeStack);
    XCTAssertEqual(healthPotion2.quantity, 0);
    XCTAssertEqual(returnedItem, healthPotion);
    
}


@end
