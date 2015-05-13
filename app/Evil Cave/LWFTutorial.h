//
//  LWFTutorial.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/10/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWFAnimationArrowInventory;
@class LWFAnimationArrowSpecialAttackView;

@interface LWFTutorial : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *labelInventoryDescription;
@property (weak, nonatomic) IBOutlet LWFAnimationArrowInventory *arrowAnimationView;
@property (weak, nonatomic) IBOutlet UILabel *labelInventoryTitle;

@property (weak, nonatomic) IBOutlet LWFAnimationArrowSpecialAttackView *viewAnimationArrowSpecialAttack;
@property (weak, nonatomic) IBOutlet UILabel *labelSpecialAttackDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelSpecialAttackTitle;

- (void)addToView:(UIView *)view;
- (void)showTutorialIfNeeded;

@end
