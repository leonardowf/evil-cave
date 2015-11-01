//
//  LWFProgressionFunctionTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/15/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LWFSkillTree.h"
#import "LWFProgressFunctionsUmbrellaHeader.h"

@interface LWFProgressionFunctionTests : XCTestCase

@end

@implementation LWFProgressionFunctionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHpPriceGrowth {
    LWFPriceFunctionHpPlus *price = [LWFPriceFunctionHpPlus new];
    
    for (NSInteger i = 0; i < 100; i++) {
        NSInteger priceCalculated = [price calculateForInput:i];
        
        NSLog(@"level: %d - price: %d", i, priceCalculated);
    }
}

- (void)testStrengthPriceGrowth {
    LWFPriceFunctionStrengthPlus *price = [LWFPriceFunctionStrengthPlus new];
    
    for (NSInteger i = 0; i < 100; i++) {
        NSInteger priceCalculated = [price calculateForInput:i];
        
        NSLog(@"level: %d - price: %d", i, priceCalculated);
    }
}

- (void)testArmorPriceGrowth {
    LWFPriceFunctionArmorUp *price = [LWFPriceFunctionArmorUp new];
    
    for (NSInteger i = 0; i < 100; i++) {
        NSInteger priceCalculated = [price calculateForInput:i];
        
        NSLog(@"level: %d - price: %d", i, priceCalculated);
    }
}

@end
