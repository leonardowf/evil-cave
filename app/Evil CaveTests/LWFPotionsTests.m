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
#import "LWFPotionFactory.h"
#import "LWFPotionIdentifierMatcher.h"

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

// TODO: Corrigir esse teste
//- (void)testIfHealthPotionHeals {
//    LWFCreatureBuilder *creatureBuilder = [[LWFCreatureBuilder alloc]initWithMap:nil movementManager:nil andMapDimension:nil andTurnList:nil andAttackManager:nil];
//    LWFPlayer *player = (LWFPlayer *)[creatureBuilder buildWithType:LWFCreatureTypeWarrior];
//    
//    player.stats.currentHP = 20;
//    
//    LWFHealthPotion *healthPotion = [LWFHealthPotion new];
//    healthPotion.quantity = 1;
//    [healthPotion applyEffectOn:player];
//    
//    NSInteger quantityHealed = [healthPotion getHealingQuantity];
//    
//    XCTAssertEqual(player.stats.currentHP, 20 + quantityHealed);
//}

- (void)testHealthPotionIdentifier {
    LWFHealthPotion *healthPotion = [LWFHealthPotion new];
    
    XCTAssertTrue([healthPotion.identifier isEqualToString:@"health_potion"]);
}

- (void)testIfHealthPotionHealsToMaximum {
    LWFCreatureBuilder *creatureBuilder = [[LWFCreatureBuilder alloc]initWithMap:nil movementManager:nil andMapDimension:nil andTurnList:nil andAttackManager:nil];
    LWFPlayer *player = (LWFPlayer *)[creatureBuilder buildWithType:LWFCreatureTypeWarrior];

    LWFHealthPotion *healthPotion = [LWFHealthPotion new];
    healthPotion.quantity = 1;
    NSInteger quantityHealed = [healthPotion getHealingQuantity];
    
    player.stats.currentHP = player.stats.maxHP - quantityHealed + 1;
    [healthPotion applyEffectOn:player];
    
    XCTAssertEqual(player.stats.currentHP, player.stats.maxHP);
}

- (void)testIfPotionFactortManufacturesHealthPotion {
    LWFPotionFactory *potionFactory = [LWFPotionFactory sharedPotionFactory];
    
    LWFPotion *potion = [potionFactory manufactureWithPotionIdentifier:@"health_potion"];
    
    XCTAssertTrue([potion isKindOfClass:[LWFHealthPotion class]]);
}

- (void)testIfTexturesAndIdentifiersAreInSameNumber {
    LWFPotionIdentifierMatcher *potionIdentifierMatcher = [[LWFPotionIdentifierMatcher alloc]init];
    
    NSInteger numberOfTextures = [[potionIdentifierMatcher allowedPotions] count];
    NSInteger numberOfPotions = [[potionIdentifierMatcher allowedTextures] count];
    
    XCTAssertEqual(numberOfPotions, numberOfTextures);
}

- (void)testIfPotionFlavorIsKnow {
    LWFPotionFactory *potionFactory = [LWFPotionFactory sharedPotionFactory];
    LWFPotion *potion = [potionFactory manufactureWithPotionIdentifier:@"health_potion"];
    LWFCreatureBuilder *creatureBuilder = [[LWFCreatureBuilder alloc]initWithMap:nil movementManager:nil andMapDimension:nil andTurnList:nil andAttackManager:nil];
    LWFPlayer *player = (LWFPlayer *)[creatureBuilder buildWithType:LWFCreatureTypeWarrior];
    
    [potion applyEffectOn:player];
    
    XCTAssertTrue([potion isKnow]);
}

- (void)testIfPotionFlavorIsUnknow {
    LWFPotionFactory *potionFactory = [LWFPotionFactory sharedPotionFactory];
    [potionFactory resetPotionKnowledgeAndTextures];
    LWFPotion *potion = [potionFactory manufactureWithPotionIdentifier:@"health_potion"];
    
    XCTAssertFalse([potion isKnow]);
}

@end
