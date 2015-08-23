//
//  LWFNewInventory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/22/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFNewInventory.h"

@implementation LWFNewInventory

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
    [[NSBundle mainBundle] loadNibNamed: @"NewInventory" owner:self options:nil];
    [self addSubview:self.containerView];
    
    [self addConstraints];
}

- (void)addConstraints {
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    
    [self addConstraints:@[c1, c2, c3, c4]];
}


@end
