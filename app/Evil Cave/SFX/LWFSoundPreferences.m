//
//  LWFSoundPreferences.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFSoundPreferences.h"
#import "LWFDictionaryConverter.h"
#import "NSDictionary+PrimitiveHelpers.h"

@implementation LWFSoundPreferences

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.musicVolume = 0.1;
        self.soundVolume = 0.5;
        
        self.musicMuted = YES;
        self.soundMuted = YES;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.musicVolume = [dictionary floatForKey:@"musicVolume"];
        self.soundVolume = [dictionary floatForKey:@"soundVolume"];
        self.soundMuted = [dictionary booleanForKey:@"soundMuted"];
        self.musicMuted = [dictionary booleanForKey:@"musicMuted"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    return [NSDictionary dictionaryWithPropertiesOfObject:self];
}

@end
