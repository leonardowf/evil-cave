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



@end
