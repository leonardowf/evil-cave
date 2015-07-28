//
//  LWFGameOverButtons.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFGameOverButtons.h"

@interface LWFGameOverButtons () {
    CGSize _intrinsic;
}
@end

@implementation LWFGameOverButtons

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"GameOverButtons" owner:self options:nil];
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
        [[NSBundle mainBundle] loadNibNamed: @"GameOverButtons" owner:self options:nil];
        [self addSubview:self.view];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (IBAction)didTapSkillTree:(id)sender {
    [_delegate showSkillTree];
}

- (IBAction)didTapRestart:(id)sender {
    [_delegate restart];
}

- (void)addBelowView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superView = view.superview;
    
    [superView addSubview:self.containerView];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    [superView addConstraint:c1];
    [superView addConstraint:c2];
    [superView addConstraint:c3];
}
@end
