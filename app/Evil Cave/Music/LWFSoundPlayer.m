//
//  LWFSoundPlayer.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import "LWFSoundPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "LWFMyScene.h"

#define PLAY_SOUND_NOTIFICATION @"NotificationPlaySound"

@interface LWFSoundPlayer () {
    LWFMyScene *_scene;
    NSDictionary *_preloadedAudios;
}
@end

@implementation LWFSoundPlayer

- (instancetype)initWithScene:(LWFMyScene *)scene
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePlayRequest:) name:PLAY_SOUND_NOTIFICATION object:nil];
        _scene = scene;
        
        [self preloadAudioFiles];
    }
    return self;
}

- (void)preloadAudioFiles {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for (NSUInteger i = 0; i < LWFSoundTypeCount; i++) {
        NSString *fileName = [LWFSoundPlayer soundFileNameForSoundType:i];
        SKAction *action = [LWFSoundPlayer actionForAudioWithName:fileName];
        [dictionary setObject:action forKey:fileName];
    }
    
    _preloadedAudios = dictionary;
}

- (void)didReceivePlayRequest:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *fileName = (NSString *)[notification object];
        
        SKAction *action = [_preloadedAudios objectForKey:fileName];
        
        [_scene runAction: action];
    }
}

+ (SKAction *)actionForAudioWithName:(NSString *)fileName {
    SKAction *action = [SKAction playSoundFileNamed:fileName waitForCompletion:NO];
    
    return action;
}

+ (void)play:(LWFSoundType)soundType {
    NSString *soundFileName = [self soundFileNameForSoundType:soundType];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:PLAY_SOUND_NOTIFICATION object:soundFileName];
}

+ (NSString *)soundFileNameForSoundType:(LWFSoundType)soundType {
    switch (soundType) {
        case LWFSoundTypePickedGold:
            return @"soundTypePickedGold.wav";
        break;
        
        default:
            return @"notFound";
        break;
    }
}

@end
