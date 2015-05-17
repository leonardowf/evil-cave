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

@protocol LWFTutorialDelegate <NSObject>
- (void)tutorialFinished;
@end

@interface LWFTutorial : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *labelInventoryDescription;
@property (weak, nonatomic) IBOutlet LWFAnimationArrowInventory *arrowAnimationView;
@property (weak, nonatomic) IBOutlet UILabel *labelInventoryTitle;

@property (weak, nonatomic) IBOutlet LWFAnimationArrowSpecialAttackView *viewAnimationArrowSpecialAttack;
@property (weak, nonatomic) IBOutlet UILabel *labelSpecialAttackDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelSpecialAttackTitle;

@property (weak, nonatomic) IBOutlet UIView *viewGif1Container;

@property (weak) id<LWFTutorialDelegate>delegate;

- (void)addToView:(UIView *)view;
- (void)showTutorialIfNeeded;

@end
