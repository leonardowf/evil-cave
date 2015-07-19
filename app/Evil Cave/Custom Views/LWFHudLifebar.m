//
//  LWFHudLifebar.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/22/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFHudLifebar.h"
#import "LWFStats.h"

@interface LWFHudLifebar () {
    CGSize _intrinsic;
    NSArray *_colors;
}
@end

@implementation LWFHudLifebar

SINGLETON_FOR_CLASS(HudLifeBar)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildColors];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"Lifebar" owner:self options:nil];
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
        [[NSBundle mainBundle] loadNibNamed: @"Lifebar" owner:self options:nil];
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
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-35];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    
    [view addConstraint:leading];
    [view addConstraint:trailing];
    [view addConstraint:top];
    [view addConstraint:height];
    
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.3];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[self.containerView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
}

- (void)buildColors {
    NSUInteger steps = 100;
    
    UIColor *fromColor = [UIColor redColor];
    UIColor *toColor = [UIColor greenColor];
    
    CGFloat fromRed;
    CGFloat fromGreen;
    CGFloat fromBlue;
    CGFloat fromAlpha;
    
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed;
    CGFloat toGreen;
    CGFloat toBlue;
    CGFloat toAlpha;
    
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat diffRed = toRed - fromRed;
    CGFloat diffGreen = toGreen - fromGreen;
    CGFloat diffBlue = toBlue - fromBlue;
    CGFloat diffAlpha = toAlpha - fromAlpha;
    
    NSMutableArray *colorArray = [NSMutableArray array];
    
    [colorArray addObject:fromColor];
    
    for (NSUInteger i = 0; i < steps - 1; ++i) {
        CGFloat red = fromRed + diffRed / steps * (i + 1);
        CGFloat green = fromGreen + diffGreen / steps * (i + 1);
        CGFloat blue = fromBlue + diffBlue / steps * (i + 1);
        CGFloat alpha = fromAlpha + diffAlpha / steps * (i + 1);
        
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [colorArray addObject:color];
    }
    
    [colorArray addObject:toColor];
    
    _colors = colorArray;
}

- (void)draw {    
    CGFloat currentPercent = (100.0 * self.stats.currentHP) / self.stats.maxHP;
    
    currentPercent = currentPercent < 0 ? 0 : currentPercent;
    self.lifeDisplayerConstraint.constant = currentPercent;
    
    NSInteger index = currentPercent;
    if (index < 0) index = 0;
    if (index > 99) index = 99;
    UIColor *color = _colors[index];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.lifeDisplayerView setBackgroundColor:color];
                         [self.lifeDisplayerView layoutIfNeeded];
                     }];
    
}

@end
