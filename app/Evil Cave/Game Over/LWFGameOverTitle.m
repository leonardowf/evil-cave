//
//  LWFGameOverTitle.m
//  Evil Cave
//
//  Created by Leonardo on 7/19/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFGameOverTitle.h"

@interface LWFGameOverTitle () {
    CGSize _intrinsic;
}

@end

@implementation LWFGameOverTitle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"GameOverTitle" owner:self options:nil];
        self.bounds = self.containerView.bounds;
        [self addSubview:self.view];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"GameOverTitle" owner:self options:nil];
        [self addSubview:self.view];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return _intrinsic;
}

- (void)addToView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:self.containerView];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:40.0];
    
    [view addConstraint:centerX];
    [view addConstraint:centerY];
    
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.3];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[self.containerView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
}


@end
