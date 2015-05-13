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
#import "LWFAnimationArrowSpecialAttackView.h"
#import <pop/POP.h>

@interface LWFTutorial () {
    BOOL _didShowInventoryTutorial;
    BOOL _didShowSpecialAttackTutorial;
    BOOL _disableInteraction;
    
    UIView *_interceptor;
}
@end

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
    return !_didShowInventoryTutorial;
}

- (void)showTutorial {
    _disableInteraction = YES;
    
    [self showViewTapInterceptorIfNeeded];
    
    if ([self shouldShowInventoryTutorial]) {
        [self showInventoryTutorial];
        return;
    }
    
    if ([self shouldShowSpecialAttackTutorial]) {
        [self showSpecialAttackTutorial];
        return;
    }
}

- (BOOL)shouldShowSpecialAttackTutorial {
    return !_didShowSpecialAttackTutorial;
}

- (void)showSpecialAttackTutorial {
    self.viewAnimationArrowSpecialAttack.alpha = 1.0;
    [self.viewAnimationArrowSpecialAttack addGrowAnimationWithCompletion:^(BOOL finished) {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.fromValue = @(0.0);
        anim.toValue = @(1.0);
        
        [anim setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            _disableInteraction = NO;
        }];
        
        [self.labelSpecialAttackDescription pop_addAnimation:anim forKey:@"fade"];
        [self.labelSpecialAttackTitle pop_addAnimation:anim forKey:@"fade"];
        
        
    }];
    
    _didShowSpecialAttackTutorial = YES;
}

- (void)showViewTapInterceptorIfNeeded {
    if (_interceptor != nil) {
        return;
    }
    
    // view que fica por cima pegando todos os taps e passando o tutorial
    
    UIView *superview = self.superview;
    _interceptor = [[UIView alloc]initWithFrame:superview.frame];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapViewInterceptor:)];
    [_interceptor addGestureRecognizer:recognizer];
    [superview addSubview:_interceptor];
}

- (void)didTapViewInterceptor:(id)sender {
    if (_disableInteraction) {
        return;
    }
    
    if ([self tutorialFinished]) {
        [self finishTutorial];
    }
    
    NSLog(@"próximo passo do tuts");
    
    [self hideAll];
}

- (void)showInventoryTutorial {
    [self.arrowAnimationView addGrowAnimationWithCompletion:^(BOOL finished) {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.fromValue = @(0.0);
        anim.toValue = @(1.0);
        
        [anim setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            _disableInteraction = NO;
        }];
        
        [self.labelInventoryDescription pop_addAnimation:anim forKey:@"fade"];
        [self.labelInventoryTitle pop_addAnimation:anim forKey:@"fade"];
    }];
    
    _didShowInventoryTutorial = YES;
}

- (void)hideAll {
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(0.0);
    [anim setCompletionBlock:^(POPAnimation *animation, BOOL someshit) {
        [self showTutorial];
    }];
    
    [self.labelInventoryDescription pop_addAnimation:anim forKey:@"fade"];
    [self.labelInventoryTitle pop_addAnimation:anim forKey:@"fade"];
    [self.labelSpecialAttackTitle pop_addAnimation:anim forKey:@"fade"];
    [self.labelSpecialAttackDescription pop_addAnimation:anim forKey:@"fade"];
    [self.viewAnimationArrowSpecialAttack pop_addAnimation:anim forKey:@"fade"];
    [self.arrowAnimationView pop_addAnimation:anim forKey:@"fade"];
}

- (BOOL)tutorialFinished {
    return _didShowSpecialAttackTutorial && _didShowInventoryTutorial;
}

- (void)finishTutorial {
    [_interceptor removeFromSuperview];
    [self removeFromSuperview];
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