//
//  LWFHudLifebar.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/22/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWFLifeDisplayer.h"

@interface LWFHudLifebar : UIView <LWFLifeDisplayer>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *lifeDisplayerView;
@property (nonatomic, strong) LWFStats *stats;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lifeDisplayerConstraint;


+ (id)sharedHudLifeBar;
- (void)addToView:(UIView *)view;

@end
