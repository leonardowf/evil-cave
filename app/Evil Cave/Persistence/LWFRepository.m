//
//  LWFRepository.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFRepository.h"
#import "LWFPersistenceStrategy.h"
#import "LWFSoundPreferences.h"

#define SOUND_PREFERENCES_KEY @"keySoundPreferences"

@interface LWFRepository () {
    id<LWFPersistenceStrategy> _strategy;
}
@end

@implementation LWFRepository

- (instancetype)initWithPersistenceStrategy:(id<LWFPersistenceStrategy>)strategy
{
    self = [super init];
    if (self) {
        _strategy = strategy;
    }
    return self;
}

- (void)saveSoundPreferences:(LWFSoundPreferences *)soundPreferences {
    [_strategy saveDictionary:[soundPreferences toDictionary] atKey:SOUND_PREFERENCES_KEY];
}

- (LWFSoundPreferences *)loadSoundPreferences {
    NSDictionary *dict = [_strategy loadDictionaryAtKey:SOUND_PREFERENCES_KEY];
    
    if (dict == nil) {
        return nil;
    }
    
    return [[LWFSoundPreferences alloc]initWithDictionary:dict];
}

@end
