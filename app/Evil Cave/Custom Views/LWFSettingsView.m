//
//  LWFSettingsView.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/25/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSettingsView.h"

@implementation LWFSettingsView

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
    [[NSBundle mainBundle] loadNibNamed:@"Settings" owner:self options:nil];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapClose)];
    
    [self.buttonCloseImageView addGestureRecognizer:tap];
    
    [self addSubview:self.view];
}

- (void)didTapClose {
    NSLog(@"pegou evento");
    
    [self.view removeFromSuperview];
}

@end
