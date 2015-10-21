//
//  LWFSkillView.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/20/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillView.h"

@implementation LWFSkillView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"LWFSkillView" owner:self options:nil];
        
        self.view.frame = self.bounds;
        
        [self addSubview:self.view];
    }
    return self;
}

@end
