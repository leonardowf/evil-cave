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
}
@end

@implementation LWFSoundPlayer

- (instancetype)initWithScene:(LWFMyScene *)scene
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePlayRequest:) name:PLAY_SOUND_NOTIFICATION object:nil];
        _scene = scene;
    }
    return self;
}

- (void)didReceivePlayRequest:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *fileName = (NSString *)[notification object];
        
        [_scene runAction:[SKAction playSoundFileNamed:fileName waitForCompletion:NO]];
    }
}

+ (void)play:(LWFSoundType)soundType {
    NSString *soundFileName = [self soundFileNameForSoundType:soundType];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:PLAY_SOUND_NOTIFICATION object:soundFileName];
}

+ (NSString *)soundFileNameForSoundType:(LWFSoundType)soundType {
    switch (soundType) {
        case LWFSoundTypePlayerHit:
            return @"soundTypePlayerHit.wav";
        break;
        
        case LWFSoundTypePickedGold:
            return @"soundTypePickedGold.wav";
        break;
        
        default:
            return @"notFound";
        break;
    }
}

@end
