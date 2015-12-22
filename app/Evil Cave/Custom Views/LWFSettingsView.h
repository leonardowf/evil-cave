//
//  LWFSettingsView.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/25/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWFSettingsView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *buttonCloseImageView;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *musicSwitch;
@property (weak, nonatomic) IBOutlet UISlider *musicVolumeSlider;

- (void)render;

@end
