//
//  LWFProgressionFunctionTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/15/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LWFPriceFunctionHpPlus.h"

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

- (void)testHpPrice {
    LWFPriceFunctionHpPlus *hpPriceFunction = [LWFPriceFunctionHpPlus new];
    
    XCTAssertEqual([hpPriceFunction calculateForInput:2], 200);
}

@end
