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
    
}

- (void)hideSettingsView {
    
}

- (void)setSettingsView:(LWFSettingsView *)settingsView {
    objc_setAssociatedObject(self, (__bridge const void *)(propertyKey), settingsView, OBJC_ASSOCIATION_RETAIN);
}

- (LWFSettingsView *)alertRequisite {
    return objc_getAssociatedObject(self, (__bridge const void *)(propertyKey));
}

@end