//
//  LWFViewController+SettingsView.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/8/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFViewController.h"
#import "LWFSettingsView.h"

@interface LWFViewController (SettingsView)

- (void)showSettingsView;
- (void)hideSettingsView;

@property (nonatomic, strong) LWFSettingsView *settingsView;
@end