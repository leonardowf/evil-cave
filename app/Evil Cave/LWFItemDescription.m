//
//  LWFItemDescription.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/11/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemDescription.h"

@interface LWFItemDescription () {
    CGSize _intrinsic;
}

@end

@implementation LWFItemDescription

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureTaps];
        
        self.bounds = self.containerView.bounds;
    }
    return self;
}

- (void)didTapImageView:(UITapGestureRecognizer *)recognizer {
    NSLog(@"porque não pega?");
}

- (void)configureTaps {
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                            action:@selector(didTapImageView:)];
    UITapGestureRecognizer *tapRec2 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                            action:@selector(didTapImageView:)];
    [self.imageViewDrop addGestureRecognizer:tapRec];
    [self.imageViewEquip addGestureRecognizer:tapRec2];
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"ItemDescription" owner:self options:nil];
        self.bounds = self.containerView.bounds;
        [self addSubview:self.containerView];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"ItemDescription" owner:self options:nil];
        [self addSubview:self.containerView];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return _intrinsic;
}

- (void)addToView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:self];
    
    NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-60];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:60];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [view addConstraint:c0];
    [view addConstraint:c1];
    [view addConstraint:c2];
}



@end
