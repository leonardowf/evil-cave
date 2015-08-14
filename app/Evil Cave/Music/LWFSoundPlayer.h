//
//  LWFSoundPlayer.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFSoundTypes.h"
@class LWFMyScene;

@interface LWFSoundPlayer : NSObject

- (instancetype)initWithScene:(LWFMyScene *)scene;

+ (void)play:(LWFSoundType)soundType;
+ (void)playMusic:(LWFMusicType)musicType;

@end
