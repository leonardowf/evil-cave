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
#import "LWFSkillTree.h"

#define SOUND_PREFERENCES_KEY @"keySoundPreferences"
#define SKILL_TREE_KEY @"keySkillTree"

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

- (void)saveSkillTree:(LWFSkillTree *)skillTree {
    [_strategy saveDictionary:[skillTree toDictionary] atKey:SKILL_TREE_KEY];
}

- (LWFSoundPreferences *)loadSoundPreferences {
    NSDictionary *dict = [_strategy loadDictionaryAtKey:SOUND_PREFERENCES_KEY];
    
    if (dict == nil) {
        return nil;
    }
    
    return [[LWFSoundPreferences alloc]initWithDictionary:dict];
}

- (LWFSkillTree *)loadSkillTree {
    NSDictionary *dict = [_strategy loadDictionaryAtKey:SKILL_TREE_KEY];
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    
    if (dict != nil) {
        [skillTree loadFromDictionary:dict];
    }
    
    return skillTree;
}
@end
