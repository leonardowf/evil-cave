//
//  LWFSettingsView.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/25/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSettingsView.h"
#import "LWFSoundPlayer.h"
#import "LWFSoundPreferences.h"
#import "LWFRepository.h"
#import "LWFUserDefaultsPersistenceStrategy.h"

@interface LWFSettingsView () {
    LWFSoundPlayer *_soundPlayer;
    LWFSoundPreferences *_soundPreferences;
}

@end

@implementation LWFSettingsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)render {
    [self loadSoundPreferences];
    
    [self.soundSwitch setOn:!_soundPreferences.soundMuted];
    [self.musicSwitch setOn:!_soundPreferences.musicMuted];
    
    NSInteger newValue = (double)self.musicVolumeSlider.maximumValue * _soundPreferences.musicVolume;
    
    [self.musicVolumeSlider setValue:newValue animated:YES];
}

- (void)loadSoundPreferences {
    LWFUserDefaultsPersistenceStrategy *persistanceStrategy = [[LWFUserDefaultsPersistenceStrategy alloc]init];
    LWFRepository *repository = [[LWFRepository alloc]initWithPersistenceStrategy:persistanceStrategy];
    
    _soundPreferences = [repository loadSoundPreferences];
    
    if (_soundPreferences == nil) {
        _soundPreferences = [[LWFSoundPreferences alloc]init];
    }
}

- (void)setup {
    [self loadSoundPreferences];
    
    [[NSBundle mainBundle] loadNibNamed:@"Settings" owner:self options:nil];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapClose)];
    
    [self.buttonCloseImageView addGestureRecognizer:tap];
    
    [self addSubview:self.view];
}

- (void)didTapClose {
    NSLog(@"pegou evento");
    
    [self.view removeFromSuperview];
}

- (IBAction)didChangeMusicSwitch:(UISwitch *)sender {
    if (sender.on) {
        [LWFSoundPlayer unmuteMusic];
    } else {
        [LWFSoundPlayer muteMusic];
    }
}

- (IBAction)didChangeSoundSwitch:(UISwitch *)sender {
    if (sender.on) {
        [LWFSoundPlayer unmuteSound];
    } else {
        [LWFSoundPlayer muteSound];
    }
}

- (IBAction)musicVolumeSwitchChanged:(id)sender {
    [LWFSoundPlayer muteSound];
}

- (IBAction)sliderMusicVolumeChanged:(UISlider *)sender {
    [LWFSoundPlayer setMusicVolume:sender.value withMaximumVolume:sender.maximumValue];
}

@end
