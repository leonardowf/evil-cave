//
//  LWFGameOverButtons.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWFGameOverButtonsDelegate <NSObject>
- (void)restart;
- (void)showSkillTree;
- (void)share;
@end

@interface LWFGameOverButtons : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *skillTreeButton;

@property (weak, nonatomic) id<LWFGameOverButtonsDelegate> delegate;

- (IBAction)didTapRestart:(id)sender;
- (void)addBelowView:(UIView *)view;

@end
