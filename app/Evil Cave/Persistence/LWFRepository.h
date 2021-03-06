//
//  LWFRepository.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFPersistenceStrategy.h"
@class LWFSoundPreferences;
@class LWFSkillTree;


@interface LWFRepository : NSObject

- (instancetype)initWithPersistenceStrategy:(id<LWFPersistenceStrategy>)strategy;
- (void)saveSoundPreferences:(LWFSoundPreferences *)soundPreferences;
- (LWFSoundPreferences *)loadSoundPreferences;

- (LWFSkillTree *)loadSkillTree;
- (void)saveSkillTree:(LWFSkillTree *)skillTree;
@end
