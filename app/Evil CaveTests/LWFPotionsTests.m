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
#import "LWFPlayer.h"
#import "LWFCreatureBuilder.h"
#import "LWFStats.h"
#import "LWFHealthPotion.h"

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

- (void)testIfHealthPotionHeals {
    LWFCreatureBuilder *creatureBuilder = [[LWFCreatureBuilder alloc]initWithMap:nil movementManager:nil andMapDimension:nil andTurnList:nil andAttackManager:nil];
    LWFPlayer *player = (LWFPlayer *)[creatureBuilder buildWithType:LWFCreatureTypeWarrior];
    
    player.stats.currentHP = 20;
    
    LWFHealthPotion *healthPotion = [LWFHealthPotion new];
    [healthPotion applyEffectOn:player];
    
    NSInteger quantityHealed = [healthPotion getHealingQuantity];
    
    XCTAssertEqual(player.stats.currentHP, 20 + quantityHealed);
}

- (void)testHealthPotionIdentifier {
    LWFHealthPotion *healthPotion = [LWFHealthPotion new];
    
    XCTAssertTrue([healthPotion.identifier isEqualToString:@"health_potion"]);
}

- (void)testIfHealthPotionHealsToMaximum {
    LWFCreatureBuilder *creatureBuilder = [[LWFCreatureBuilder alloc]initWithMap:nil movementManager:nil andMapDimension:nil andTurnList:nil andAttackManager:nil];
    LWFPlayer *player = (LWFPlayer *)[creatureBuilder buildWithType:LWFCreatureTypeWarrior];

    LWFHealthPotion *healthPotion = [LWFHealthPotion new];
    NSInteger quantityHealed = [healthPotion getHealingQuantity];
    
    player.stats.currentHP = player.stats.maxHP - quantityHealed + 1;
    [healthPotion applyEffectOn:player];
    
    XCTAssertEqual(player.stats.currentHP, player.stats.maxHP);
}

@end
