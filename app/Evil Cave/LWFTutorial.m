//
//  LWFTutorial.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/10/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFTutorial.h"
#import <pop/POP.h>
#import "LWFAnimationArrowInventory.h"
#import <pop/POP.h>

@implementation LWFTutorial

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"Tutorial" owner:self options:nil];
        self.bounds = self.view.bounds;
        [self addSubview:self.view];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"Tutorial" owner:self options:nil];
        [self addSubview:self.view];
    }
    return self;
}

- (void)showTutorialIfNeeded {
    if ([self shouldShowTutorial]) {
        [self showTutorial];
    }
}

- (BOOL)shouldShowTutorial {
    return YES;
}

- (BOOL)shouldShowInventoryTutorial {
    return YES;
}

- (void)showTutorial {
    [self showViewTapInterceptor];
    
    if ([self shouldShowInventoryTutorial]) {
        [self showInventoryTutorial];
        
    }
}

- (void)showViewTapInterceptor {
    // view que fica por cima pegando todos os taps e passando o tutorial
    
    UIView *superview = self.superview;
    UIView *interceptor = [[UIView alloc]initWithFrame:superview.frame];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapViewInterceptor:)];
    [interceptor addGestureRecognizer:recognizer];
    [superview addSubview:interceptor];
}

- (void)didTapViewInterceptor:(id)sender {
    NSLog(@"próximo passo do tuts");
}

- (void)showInventoryTutorial {
    [self.arrowAnimationView addGrowAnimationWithCompletion:^(BOOL finished) {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.fromValue = @(0.0);
        anim.toValue = @(1.0);
        [self.labelInventoryDescription pop_addAnimation:anim forKey:@"fade"];
    }];
}

- (void)addToView:(UIView *)view {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:self.view];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    
    NSArray *cs = @[c1, c2, c3, c4];
    
    [view addConstraints:cs];
}

@end
