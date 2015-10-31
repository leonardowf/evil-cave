//
//  LWFSkillTreeTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/30/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LWFSkillTree.h"
#import "NSDictionary+PrimitiveHelpers.h"
#import "LWFDictionaryConverter.h"

@interface LWFSkillTreeTests : XCTestCase

@end

@implementation LWFSkillTreeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInstantiationWithDictionary {    
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    
    NSInteger testHPLevel = 10;
    
    skillTree.HPLevel = testHPLevel;
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithPropertiesOfObject:skillTree];
    
    [skillTree loadFromDictionary:dictionary];
    
    XCTAssertEqual(skillTree.HPLevel, testHPLevel);
}

- (void)testCleareance {
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    [skillTree clear];
}

@end
