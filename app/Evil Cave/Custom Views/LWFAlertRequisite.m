//
//  LWFAlertRequisite.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/9/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFAlertRequisite.h"
#import <pop/POP.h>

@implementation LWFAlertRequisite

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

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"AlertRequisite" owner:self options:nil];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.view];
}

- (void)render {
    
}

@end

@implementation LWFViewController (AlertRequisite)

- (void)openAlertForRequisite:(LWFRequisite *)requisite {
    LWFAlertRequisite *alertRequisite = [[LWFAlertRequisite alloc]initWithFrame:CGRectZero];
    
    UIView *alertRequisiteView = alertRequisite.view;
    
    alertRequisiteView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:alertRequisiteView];
    
    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:alertRequisiteView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *constraintCenterY = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:alertRequisiteView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-100.0];
    
    
    [self.view addConstraints:@[constraintCenterX, constraintCenterY]];
    
    [self.view bringSubviewToFront:alertRequisiteView];
    
    [alertRequisite render];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    animation.springBounciness = 4;
    
    animation.toValue = @0;
    
    [constraintCenterY pop_addAnimation:animation forKey:@"size"];
}

@end

