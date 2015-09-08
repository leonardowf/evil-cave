//
//  LWFSoundPlayer.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFSoundTypes.h"
#import "LWFSoundEmitter.h"

@class LWFMyScene;

@interface LWFSoundPlayer : NSObject

- (instancetype)initWithScene:(LWFMyScene *)scene;

+ (void)play:(LWFSoundType)soundType;
+ (void)play:(LWFSoundType)soundType withSoundEmitter:(id<LWFSoundEmitter>)soundEmitter;
+ (void)playMusic:(LWFMusicType)musicType;
+ (void)stopMusic;
+ (void)muteMusic;
+ (void)muteSound;
+ (void)increaseMusicVolume;
+ (void)decreaseMusicVolume;

@end
