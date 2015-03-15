//
//  LWFItemDescription.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/11/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemDescription.h"

#import "LWFItem.h"
#import "LWFInventory.h"

@interface LWFItemDescription () {
    CGSize _intrinsic;
}

@end

@interface LWFItemDescription () {
    LWFItem *_item;
    LWFInventory *_inventory;
}
@end

@implementation LWFItemDescription

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addOutlineToLabel:self.labelTitle];
    }
    return self;
}

- (instancetype)initWithItem:(LWFItem *)item andInventory:(LWFInventory *)inventory
{
    self = [self init];
    if (self) {
        _item = item;
        _inventory = inventory;
        
        [self fillLabels];
    }
    return self;
}

- (void)addOutlineToLabel:(UILabel *)label {
    UIColor *aColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:125/2550 alpha:1];
    
    label.layer.shadowColor = [aColor CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.layer.shadowOpacity = 1.0f;
    label.layer.shadowRadius = 1.0f;
}

- (void)fillLabels {
    self.labelTitle.text = _item.name;
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"ItemDescription" owner:self options:nil];
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
        [[NSBundle mainBundle] loadNibNamed: @"ItemDescription" owner:self options:nil];
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
    
    NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-60];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:60];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [view addConstraint:c0];
    [view addConstraint:c1];
    [view addConstraint:c2];
    
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.3];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[self.containerView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
}

- (void)removeFromSuperview:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.4
                         animations:^{self.alpha = 0.0;}
                         completion:^(BOOL finished){ [self.containerView removeFromSuperview]; }];
    } else {
        [self.containerView removeFromSuperview];
    }
}

- (IBAction)didTapEquip:(id)sender {
    [self removeFromSuperview:YES];
    
    [_inventory equip:_item];
}

- (IBAction)didTapDrop:(id)sender {
    [self removeFromSuperview:sender];
    
    [_inventory drop:_item];
}

@end
