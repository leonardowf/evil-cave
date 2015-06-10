//
//  LWFNewItemDescription.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/9/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFNewItemDescription.h"

#import <pop/POP.h>

@interface LWFNewItemDescription () {
    CGSize _intrinsic;
}
@end

@implementation LWFNewItemDescription

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: [self getNibName] owner:self options:nil];
        
        UIView *containerView = [self getContainerView];
        UIView *view = [self getView];
        
        self.bounds = containerView.bounds;
        [self addSubview:view];
        _intrinsic = view.bounds.size;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: [self getNibName] owner:self options:nil];
        
        UIView *view = [self getView];
        
        [self addSubview:view];
        _intrinsic = view.bounds.size;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return _intrinsic;
}

- (void)addToView:(UIView *)view {
    UIView *containerView = [self getContainerView];
    
    [containerView setAlpha:0.0];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:containerView];
    
    NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-60];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:60];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [view addConstraint:c0];
    [view addConstraint:c1];
    [view addConstraint:c2];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);
    opacityAnimation.beginTime = 0;
    opacityAnimation.duration = 1;
    [containerView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    POPSpringAnimation *heightAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    heightAnimation.springBounciness = 0;
    heightAnimation.toValue = @(10.);
    heightAnimation.fromValue = @(-100);
    
    [c2 pop_addAnimation:heightAnimation forKey:@"fullscreen"];
}

- (void)removeFromSuperview:(BOOL)animated {
    UIView *containerView = [self getContainerView];
    
    if (!animated) {
        [containerView removeFromSuperview];
        return;
    }
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0);
    opacityAnimation.beginTime = 0;
    opacityAnimation.duration = 0.5;
    [containerView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    [opacityAnimation setCompletionBlock:^(POPAnimation *animation, BOOL completed) {
        [containerView removeFromSuperview];
    }];
}

- (UIView *)getContainerView {
    // subsclasses devem implementar
    return nil;
}

- (UIView *)getView {
    // subclasses devem implementar
    return nil;
}

- (NSString *)getNibName {
    // subclasses devem implementar
    return nil;
}

@end
