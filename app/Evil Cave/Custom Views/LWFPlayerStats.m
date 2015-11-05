//
//  LWFPlayerStats.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/4/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFPlayerStats.h"

@implementation LWFPlayerStats

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"PlayerStats" owner:self options:nil];
        
        self.view.frame = self.bounds;
        [self addSubview:self.view];
    }
    return self;
}

@end
