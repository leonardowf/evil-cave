//
//  LWFSoundPlayer.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import "LWFSoundPlayer.h"
#import "LWFMyScene.h"
#import <AVFoundation/AVFoundation.h>

#define PLAY_SOUND_NOTIFICATION @"NotificationPlaySound"
#define PLAY_MUSIC_NOTIFICATION @"NotificationPlayMusic"
#define STOP_MUSIC_NOTIFICATION @"NotificationStopMusic"

@interface LWFSoundPlayer () {
    LWFMyScene *_scene;
    
    NSDictionary *_preloadedAudios;
    NSDictionary *_preloadedMusic;
    
    SKAction *_currentPlayingMusic;
    AVAudioPlayer *_audioPlayer;
}
@end

@implementation LWFSoundPlayer

- (instancetype)initWithScene:(LWFMyScene *)scene
{
    self = [super init];
    if (self) {
        _scene = scene;
        
        [self registerForNotifications];
        [self preloadAudioFiles];
    }
    return self;
}

- (void)registerForNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    NSDictionary *notificationsDictionary = @{
                                              PLAY_SOUND_NOTIFICATION: @"didReceivePlayRequest:",
                                              PLAY_MUSIC_NOTIFICATION: @"didReceivePlayMusicRequest:",
                                              STOP_MUSIC_NOTIFICATION: @"didReceiveStopMusicRequest:"
                                              };
    
    for (NSString* key in notificationsDictionary) {
        NSString *value = [notificationsDictionary objectForKey:key];

        [notificationCenter addObserver:self selector: NSSelectorFromString(value)
                                                     name:key
                                                   object:nil];
    }
}

+ (void)play:(LWFSoundType)soundType {
    NSString *soundFileName = [self soundFileNameForSoundType:soundType];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:PLAY_SOUND_NOTIFICATION
                                                       object:soundFileName];
}

+ (void)playMusic:(LWFMusicType)musicType {
    NSString *musicFileName = [self musicFileNameForMusicType:musicType];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:PLAY_MUSIC_NOTIFICATION
                                                       object:musicFileName];
}

+ (void)stopMusic {
}

- (void)preloadAudioFiles {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for (NSUInteger i = 0; i < LWFSoundTypeCount; i++) {
        NSString *fileName = [LWFSoundPlayer soundFileNameForSoundType:i];
        SKAction *action = [LWFSoundPlayer actionForAudioWithName:fileName isMusic:NO];
        [dictionary setObject:action forKey:fileName];
    }
    
    _preloadedAudios = dictionary;
    
    dictionary = [NSMutableDictionary new];
    
    for (NSUInteger i = 0; i < LWFMusicTypeCount; i++) {
        NSString *fileName = [LWFSoundPlayer musicFileNameForMusicType:i];
        SKAction *action = [LWFSoundPlayer actionForAudioWithName:fileName isMusic:YES];
        [dictionary setObject:action forKey:fileName];
    }
    
    _preloadedMusic = dictionary;
}

- (void)didReceivePlayRequest:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *fileName = (NSString *)[notification object];
        
        SKAction *action = [_preloadedAudios objectForKey:fileName];
        
        
        [_scene runAction: action];
    }
}

- (void)didReceivePlayMusicRequest:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *fileName = (NSString *)[notification object];
        
        NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], fileName];
        NSURL *soundUrl = [NSURL fileURLWithPath:path];
        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
        [_audioPlayer play];
    }
}

+ (SKAction *)actionForAudioWithName:(NSString *)fileName isMusic:(BOOL)music {
    SKAction *action = [SKAction playSoundFileNamed:fileName waitForCompletion:music];
    
    return action;
}

+ (NSString *)musicFileNameForMusicType:(LWFMusicType)musicType {
    
    switch (musicType) {
        case LWFMusicTypeMenu:
            return @"musicTypeMenu.mp3";
        break;
        default:
            return nil;
    }
    
    return nil;
}

+ (NSString *)soundFileNameForSoundType:(LWFSoundType)soundType {
    switch (soundType) {
        case LWFSoundTypePickedGold:
            return @"soundTypePickedGold.wav";
        break;
        
        case LWFSoundTypeGameOver:
            return @"soundTypeGameOver.mp3";
        break;
        
        default:
            return @"notFound";
        break;
    }
}

@end
