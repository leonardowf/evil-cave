//
//  LWFGameOverStats.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/21/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWFGameOverStats : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *labelGold;

- (void)addBelowView:(UIView *)view;
@end
