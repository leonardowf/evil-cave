//
//  LWFViewController+SettingsView.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/8/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFViewController+SettingsView.h"
#import <pop/POP.h>
#import <objc/runtime.h>

NSString * const propertyKey = @"SettingsView";

@implementation LWFViewController (SettingsView)

@dynamic settingsView;

- (void)showSettingsView {
    if (self.settingsView != nil) {
        [self.settingsView.view removeFromSuperview];
        self.settingsView = nil;
    }
    
    LWFSettingsView *settingsView = [[LWFSettingsView alloc]initWithFrame:CGRectZero];
    
    UIView *settingsViewView = settingsView.view;
    
    settingsViewView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:settingsViewView];
    
    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:settingsViewView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *constraintCenterY = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:settingsViewView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-100.0];
    
    
    [self.view addConstraints:@[constraintCenterX, constraintCenterY]];
    
    [self.view bringSubviewToFront:settingsViewView];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    animation.springBounciness = 4;
    
    animation.toValue = @0;
    
    [constraintCenterY pop_addAnimation:animation forKey:@"size"];
    
    [self setSettingsView:settingsView];
}

- (void)hideSettingsView {
    
}

- (void)setSettingsView:(LWFSettingsView *)settingsView {
    objc_setAssociatedObject(self, (__bridge const void *)(propertyKey), settingsView, OBJC_ASSOCIATION_RETAIN);
}

- (LWFSettingsView *)settingsView {
    return objc_getAssociatedObject(self, (__bridge const void *)(propertyKey));
}

@end