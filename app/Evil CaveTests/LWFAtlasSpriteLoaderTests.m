//
//  LWFAtlasSpriteLoaderTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 9/14/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LWFAtlasSpriteLoader.h"

@interface LWFAtlasSpriteLoaderTests : XCTestCase {
    LWFAtlasSpriteLoader *_atlasSpriteLoader;
}

@end

@implementation LWFAtlasSpriteLoaderTests

- (void)setUp {
    [super setUp];
    
    _atlasSpriteLoader = [[LWFAtlasSpriteLoader alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
