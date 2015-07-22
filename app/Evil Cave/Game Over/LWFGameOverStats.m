//
//  LWFGameOverStats.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/21/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFGameOverStats.h"

@interface LWFGameOverStats () {
    CGSize _intrinsic;
}
@end

@implementation LWFGameOverStats

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"GameOverStats" owner:self options:nil];
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
        [[NSBundle mainBundle] loadNibNamed: @"GameOverStats" owner:self options:nil];
        [self addSubview:self.view];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return _intrinsic;
}

@end
