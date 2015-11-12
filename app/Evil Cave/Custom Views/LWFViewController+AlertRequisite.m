//
//  LWFViewController+AlertRequisite.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFViewController+AlertRequisite.h"
#import "LWFRequisite.h"
#import <pop/POP.h>
#import "LWFAlertRequisite.h"
#import <objc/runtime.h>

NSString * const alertRequisitePropertyKey = @"alertRequisitePropertyKey";

@implementation LWFViewController (AlertRequisite)

@dynamic alertRequisite;

- (void)openAlertForRequisite:(LWFRequisite *)requisite {
    if (self.alertRequisite != nil) {
        [self.alertRequisite removeFromSuperview];
        self.alertRequisite = nil;
    }
    
    LWFAlertRequisite *alertRequisite = [[LWFAlertRequisite alloc]initWithFrame:CGRectZero];
    
    UIView *alertRequisiteView = alertRequisite.view;
    
    alertRequisiteView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:alertRequisiteView];
    
    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:alertRequisiteView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *constraintCenterY = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:alertRequisiteView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-100.0];
    
    
    [self.view addConstraints:@[constraintCenterX, constraintCenterY]];
    
    [self.view bringSubviewToFront:alertRequisiteView];
    
    alertRequisite.requisite = requisite;
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    animation.springBounciness = 4;
    
    animation.toValue = @0;
    
    [constraintCenterY pop_addAnimation:animation forKey:@"size"];
    
    [self setAlertRequisite:alertRequisite];
}

- (void)setAlertRequisite:(LWFAlertRequisite *)alertRequisite {
    objc_setAssociatedObject(self, (__bridge const void *)(alertRequisitePropertyKey), alertRequisite, OBJC_ASSOCIATION_RETAIN);
}

- (LWFRequisite *)alertRequisite {
    return objc_getAssociatedObject(self, (__bridge const void *)(alertRequisitePropertyKey));
}

@end