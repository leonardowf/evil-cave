//
//  LWFSoundPreferencesTests.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LWFSoundPreferences.h"
#import "LWFPersistenceStrategy.h"
#import "LWFRepository.h"
#import "LWFMockPersistanceStrategy.h"

@interface LWFSoundPreferencesTests : XCTestCase

@end

@implementation LWFSoundPreferencesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfSoundPreferencesConvertsCorrectly {
    LWFSoundPreferences *soundPreferences = [LWFSoundPreferences new];
    soundPreferences.musicVolume = 0.5;
    soundPreferences.musicMuted = true;
    soundPreferences.soundMuted = true;
    
    NSDictionary *dict = [soundPreferences toDictionary];
    
    LWFSoundPreferences *loadedSoundPreferences = [[LWFSoundPreferences alloc]initWithDictionary:dict];
    
    XCTAssertEqual(soundPreferences.musicVolume, loadedSoundPreferences.musicVolume);
    XCTAssertEqual(soundPreferences.soundMuted, loadedSoundPreferences.soundMuted);
    XCTAssertEqual(soundPreferences.musicMuted, loadedSoundPreferences.musicMuted);
}

- (void)testRepositoryPersistence {
    LWFRepository *repository = [[LWFRepository alloc]initWithPersistenceStrategy:[LWFMockPersistanceStrategy new]];
    LWFSoundPreferences *soundPreferences = [LWFSoundPreferences new];
    soundPreferences.musicVolume = 0.5;
    
    [repository saveSoundPreferences:soundPreferences];
    
    LWFSoundPreferences *loadedSoundPreferences = [repository loadSoundPreferences];
    
    XCTAssertEqual(soundPreferences.musicVolume, loadedSoundPreferences.musicVolume);
    XCTAssertEqual(soundPreferences.soundMuted, loadedSoundPreferences.soundMuted);
    XCTAssertEqual(soundPreferences.musicMuted, loadedSoundPreferences.musicMuted);
}

@end
