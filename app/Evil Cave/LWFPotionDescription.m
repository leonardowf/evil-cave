//
//  LWFPotionDescription.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotionDescription.h"
#import "LWFPotion.h"
#import "LWFInventory.h"
#import <pop/POP.h>

@interface LWFPotionDescription () {
    LWFInventory *_inventory;
    LWFPotion *_potion;
    CGSize _intrinsic;
}
@end

@implementation LWFPotionDescription

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithItem:(LWFPotion *)potion
                andInventory:(LWFInventory *)inventory {
    
    self = [self init];
    
    if (self) {
        _inventory = inventory;
        _potion = potion;
    }
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"PotionDescription" owner:self options:nil];
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
        [[NSBundle mainBundle] loadNibNamed: @"PotionDescription" owner:self options:nil];
        [self addSubview:self.view];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return _intrinsic;
}

- (void)addToView:(UIView *)view {
    [self.containerView setAlpha:0.0];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:self.containerView];
    
    NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-60];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:60];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [view addConstraint:c0];
    [view addConstraint:c1];
    [view addConstraint:c2];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);
    opacityAnimation.beginTime = 0;
    opacityAnimation.duration = 1;
    [self.containerView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    POPSpringAnimation *heightAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    heightAnimation.springBounciness = 0;
    heightAnimation.toValue = @(10.);
    heightAnimation.fromValue = @(-100);
    
    [c2 pop_addAnimation:heightAnimation forKey:@"fullscreen"];
}

- (void)removeFromSuperview:(BOOL)animated {
    if (!animated) {
        [self.containerView removeFromSuperview];
        return;
    }
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0);
    opacityAnimation.beginTime = 0;
    opacityAnimation.duration = 0.5;
    [self.containerView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    [opacityAnimation setCompletionBlock:^(POPAnimation *animation, BOOL completed) {
        [self.containerView removeFromSuperview];
    }];
}

- (IBAction)didTapDrinkButton:(id)sender {
}

- (IBAction)didTapThrowButton:(id)sender {
}

- (IBAction)didTapDropButton:(id)sender {
}


@end
