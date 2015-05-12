//
//  LWFTutorial.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/10/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWFAnimationArrowInventory;
@interface LWFTutorial : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *labelInventoryDescription;
@property (weak, nonatomic) IBOutlet LWFAnimationArrowInventory *arrowAnimationView;

- (void)addToView:(UIView *)view;
- (void)showTutorialIfNeeded;

@end
