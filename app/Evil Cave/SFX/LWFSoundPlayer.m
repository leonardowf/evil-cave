//
//  LWFSoundPlayer.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//
#import "LWFSoundPlayer.h"
#import "LWFMyScene.h"
#import <AVFoundation/AVFoundation.h>
#import "LWFSoundPreferences.h"
#import "LWFRepository.h"
#import "LWFPersistenceStrategy.h"
#import "LWFUserDefaultsPersistenceStrategy.h"

#define PLAY_SOUND_NOTIFICATION             @"NotificationPlaySound"
#define PLAY_MUSIC_NOTIFICATION             @"NotificationPlayMusic"
#define STOP_MUSIC_NOTIFICATION             @"NotificationStopMusic"
#define MUTE_MUSIC_NOTIFICATION             @"NotificationMuteMusic"
#define MUTE_SOUND_NOTIFICATION             @"NotificationMuteSound"
#define UNMUTE_MUSIC_NOTIFICATION           @"NotificationUnmuteMusic"
#define UNMUTE_SOUND_NOTIFICATION           @"NotificationUnmuteSound"
#define DECREASE_MUSIC_VOLUME_NOTIFICATION  @"NotificationDecreaseMusicVolume"
#define INCREASE_MUSIC_VOLUME_NOTIFICATION  @"NotificationIncreaseMusicVolume"

@interface LWFSoundPlayer () {
    NSDictionary *_preloadedAudios;
    NSDictionary *_preloadedMusic;
    
    AVAudioPlayer *_currentPlayingMusic;
    
    LWFSoundPreferences *_soundPreferences;
    LWFRepository *_repository;
}
@end

@implementation LWFSoundPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {        
        LWFUserDefaultsPersistenceStrategy *persistanceStrategy = [[LWFUserDefaultsPersistenceStrategy alloc]init];
        _repository = [[LWFRepository alloc]initWithPersistenceStrategy:persistanceStrategy];
        
        [self loadPreferences];
        
        [self registerForNotifications];
        [self preloadAudioFiles];
    }
    return self;
}

- (void)registerForNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    /**
     *  Dicionário que mapeia os as notificações e os métodos que serão executa-
        dos
     */
    NSDictionary *notificationsDictionary = @{
                                              PLAY_SOUND_NOTIFICATION:              @"didReceivePlayRequest:",
                                              PLAY_MUSIC_NOTIFICATION:              @"didReceivePlayMusicRequest:",
                                              STOP_MUSIC_NOTIFICATION:              @"didReceiveStopMusicRequest",
                                              MUTE_MUSIC_NOTIFICATION:              @"didReceiveMuteMusicRequest",
                                              MUTE_SOUND_NOTIFICATION:              @"didReceiveMuteSoundRequest",
                                              UNMUTE_MUSIC_NOTIFICATION:            @"didReceiveUnmuteMusicRequest",
                                              UNMUTE_SOUND_NOTIFICATION:            @"didReceiveUnmuteSoundRequest",
                                              DECREASE_MUSIC_VOLUME_NOTIFICATION:   @"didReceiveDecreaseMusicVolumeRequest",
                                              INCREASE_MUSIC_VOLUME_NOTIFICATION:   @"didReceiveIncreaseMusicVolumeRequest"
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

+ (void)play:(LWFSoundType)soundType withSoundEmitter:(id<LWFSoundEmitter>)soundEmitter {
    NSString *soundFileName = [soundEmitter getSoundName:soundType];
    
    if (soundFileName != nil) {
        [[NSNotificationCenter defaultCenter]postNotificationName:PLAY_SOUND_NOTIFICATION
                                                           object:soundFileName];
    }
}

+ (void)playMusic:(LWFMusicType)musicType {
    NSString *musicFileName = [self musicFileNameForMusicType:musicType];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:PLAY_MUSIC_NOTIFICATION
                                                       object:musicFileName];
}

+ (void)stopMusic {
    [[NSNotificationCenter defaultCenter]postNotificationName:STOP_MUSIC_NOTIFICATION
                                                       object:nil];
}

+ (void)muteMusic {
    [[NSNotificationCenter defaultCenter]postNotificationName:MUTE_MUSIC_NOTIFICATION
                                                       object:nil];
}

+ (void)muteSound {
    [[NSNotificationCenter defaultCenter]postNotificationName:MUTE_SOUND_NOTIFICATION
                                                       object:nil];
    
}

+ (void)unmuteMusic {
    [[NSNotificationCenter defaultCenter]postNotificationName:UNMUTE_MUSIC_NOTIFICATION
                                                       object:nil];
}

+ (void)unmuteSound {
    [[NSNotificationCenter defaultCenter]postNotificationName:UNMUTE_SOUND_NOTIFICATION
                                                       object:nil];
    
}

+ (void)increaseMusicVolume {
    [[NSNotificationCenter defaultCenter]postNotificationName:INCREASE_MUSIC_VOLUME_NOTIFICATION
                                                       object:nil];
}

+ (void)decreaseMusicVolume {
    [[NSNotificationCenter defaultCenter]postNotificationName:DECREASE_MUSIC_VOLUME_NOTIFICATION
                                                       object:nil];
}

- (void)preloadAudioFiles {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for (NSUInteger i = 0; i < LWFSoundTypeCount; i++) {
        NSString *fileName = [LWFSoundPlayer soundFileNameForSoundType:i];
        AVAudioPlayer *audioPlayer = [LWFSoundPlayer audioPlayerForMusicFileName: fileName];
        [dictionary setObject:audioPlayer forKey:fileName];
    }
    
    [self preloadOtherAudiosIntoDictionary:dictionary];
    
    dictionary = [NSMutableDictionary new];
    
    for (NSUInteger i = 0; i < LWFMusicTypeCount; i++) {
        NSString *fileName = [LWFSoundPlayer musicFileNameForMusicType:i];
        AVAudioPlayer *audioPlayer = [LWFSoundPlayer audioPlayerForMusicFileName:fileName];
        [dictionary setObject:audioPlayer forKey:fileName];
    }
    
    _preloadedMusic = dictionary;
}

- (void)preloadOtherAudiosIntoDictionary:(NSMutableDictionary *)dictionary {
    AVAudioPlayer *audioPlayer = [LWFSoundPlayer audioPlayerForMusicFileName:@"ratHit.wav"];
    [dictionary setObject:audioPlayer forKey:@"ratHit.wav"];
    
    _preloadedAudios = dictionary;
}

- (void)didReceivePlayRequest:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *fileName = (NSString *)[notification object];
        
        AVAudioPlayer *audioPlayer = [_preloadedAudios objectForKey:fileName];
        
        audioPlayer.volume = _soundPreferences.soundVolume;
        
        if (!_soundPreferences.soundMuted) {
            [audioPlayer play];
        }
    }
}

- (void)didReceivePlayMusicRequest:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSString class]]) {
        [_currentPlayingMusic stop];
        
        NSString *fileName = (NSString *)[notification object];
        _currentPlayingMusic = [_preloadedMusic objectForKey:fileName];
        
        _currentPlayingMusic.volume = _soundPreferences.musicVolume;
        
        // Repete indefinidamente
        _currentPlayingMusic.numberOfLoops = -1;

        
        if (!_soundPreferences.musicMuted) {
            [_currentPlayingMusic play];
        }
    }
}

- (void)didReceiveStopMusicRequest {
    [_currentPlayingMusic stop];
    _currentPlayingMusic.currentTime = 0;
    _currentPlayingMusic = nil;
}

- (void)didReceiveMuteMusicRequest {
    _currentPlayingMusic.volume = 0.0;
    _soundPreferences.musicMuted = YES;
    [self savePreferences];
}

- (void)didReceiveMuteSoundRequest {
    _soundPreferences.soundMuted = YES;
    [self savePreferences];
}

- (void)didReceiveUnmuteSoundRequest {
    _soundPreferences.soundMuted = NO;
    [self savePreferences];
}

- (void)didReceiveUnmuteMusicRequest {
    _soundPreferences.musicMuted = NO;
    _currentPlayingMusic.volume = _soundPreferences.musicVolume;
    [self savePreferences];
}

- (void)didReceiveDecreaseMusicVolumeRequest {
    if (_currentPlayingMusic.volume == 0.0) {
        return;
    }
    
    _currentPlayingMusic.volume = _currentPlayingMusic.volume - 0.1;
    
    [self savePreferences];
}

- (void)didReceiveIncreaseMusicVolumeRequest {
    if (_currentPlayingMusic.volume == 1.0) {
        return;
    }
    
    _currentPlayingMusic.volume = _currentPlayingMusic.volume + 0.1;
    
    [self savePreferences];
}

/**
 *  Salva localmente informações sobre mute e volumes
 */
- (void)savePreferences {
    [_repository saveSoundPreferences:_soundPreferences];
}

/**
 *  Carrega informações de mute e volumes
 */
- (void)loadPreferences {
    _soundPreferences = [_repository loadSoundPreferences];
    
    if (_soundPreferences == nil) {
        _soundPreferences = [[LWFSoundPreferences alloc]init];
    }
}

+ (AVAudioPlayer *)audioPlayerForMusicFileName:(NSString *)musicFileName {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], musicFileName];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    return [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
}

+ (NSString *)musicFileNameForMusicType:(LWFMusicType)musicType {
    
    switch (musicType) {
        case LWFMusicTypeGame:
            return @"badasswolfshirt-famouser.mp3";
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
            return @"notFound.wav";
        break;
    }
}

@end
