//
//  LWFViewController.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFViewController.h"
#import "LWFMyScene.h"
#import "LWFPlayer.h"
#import "LWFInventory.h"
#import "LWFHudLogger.h"

#import "LWFHudLifebar.h"

#import "LWFOTE.h"
#import "LWFOTEQueue.h"
#import "LWFOTESpinningCooldown.h"
#import "LWFEquipment.h"

#import "LWFTutorial.h"
#import "LWFGameController.h"

#import "QuartzCore/QuartzCore.h"
#import <pop/POP.h>
#import "LWFTutorial.h"
#import "LWFPieView.h"
#import "LWFPlayerStats.h"
#import "LWFSoundPlayer.h"

@implementation LWFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.viewTutorial setDelegate:self];
    
    LWFGameController *gameController = [LWFGameController sharedGameController];
    gameController.rootController = self;
    
    [self tutorialFinished];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.viewSpecialAttackButton.hidden = ![self shouldShowSkillTree];
    
//    [self.viewTutorial showTutorialIfNeeded];

}

- (BOOL)shouldShowSkillTree {
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    return [skillTree currentLevelForSkillType:LWFSkillTypeSpinningAttackLevelUp] > 0;
}

- (void)tutorialFinished {
    [self.viewTutorial removeFromSuperview];
    SKView * skView = (SKView *)self.view;
    
//     Create and configure the scene.
    SKScene * scene = [LWFMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene.
    [skView presentScene:scene];

    [self configureEvents];

    LWFInventory *inventory = [LWFInventory sharedInventory];
    [inventory inject:self];

    LWFHudLogger *hugLogger = [LWFHudLogger sharedHudLogger];
    [hugLogger inject:self];

    [self.imageViewWeapon.layer setMinificationFilter:kCAFilterTrilinear];
    [self.imageViewWeapon.layer setMagnificationFilter:kCAFilterTrilinear];

    LWFHudLifebar *lifebar = [LWFHudLifebar sharedHudLifeBar];
    [lifebar addToView:self.view];
    
    lifebar.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapLifeBar)];
    [lifebar.containerView addGestureRecognizer:tapGesture];
}

- (void)didTapLifeBar {
    NSLog(@"didTapLifeBar");
    
    [self openPlayerStats];
}

- (void)openPlayerStats {
    LWFPlayerStats *playerStatsView = [[LWFPlayerStats alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];

        playerStatsView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:playerStatsView];

    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:playerStatsView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *constraintCenterY = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:playerStatsView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-100.0];
    
    
    [self.view addConstraints:@[constraintCenterX, constraintCenterY]];
    
    [self.view bringSubviewToFront:playerStatsView];
    
    [playerStatsView render];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    animation.springBounciness = 4;
    
    animation.toValue = @0;
    
    [constraintCenterY pop_addAnimation:animation forKey:@"size"];

}

- (void)configureEvents {
}

- (void)notificationShowItemPreview:(NSNotification *)notification {
    NSMutableArray *itemsStepped = [notification object];
    
    [self showPreviewForItems:itemsStepped];
}

- (void)showPreviewForItems:(NSMutableArray *) itemsStepped {
    if (itemsStepped == nil || itemsStepped.count == 0) {
        [self.view layoutIfNeeded];
        
        self.rightConstraint.constant = -16;
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.view layoutIfNeeded];
                         }];
    } else {
        
        [self.view layoutIfNeeded];
        
        self.rightConstraint.constant = 147;
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.view layoutIfNeeded];
                         }];
        
        LWFItem *item = [itemsStepped lastObject];
        
        if ([item isEquipment]) {
            LWFEquipment *equipment = (LWFEquipment *)item;
            self.labelName.text = [equipment getName];
            self.labelDamage.text = [equipment damageText];
            self.labelHP.text = [equipment hpText];
            self.labelStrength.text = [equipment strengthText];
            self.labelArmor.text = [equipment armorText];
        }
        
        UIImage *itemImage = [UIImage imageNamed:[NSString stringWithFormat:@"item_%@", item.imageName]];
        
        self.imageViewItemSprite.image = itemImage;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)didTouchItemPreview:(id)sender {
    
}

- (IBAction)didTapInventoryButton:(UITapGestureRecognizer *)sender {
    UIView *view = (UIView *)sender.view;
    
    [LWFSoundPlayer play:LWFSoundTypeUIClick];
    
    [self animateOnPressButton:view completion:^{
        LWFInventory *inventory = [LWFInventory sharedInventory];
        [inventory show];
    }];
}

- (void)animateOnPressButton:(UIView *)button completion:(void(^)(void))someBlock {
    CGRect baseRect = CGRectMake(button.frame.origin.x + 0, button.frame.origin.y + 5, button.frame.size.width, button.frame.size.height);
    
    [button pop_removeAllAnimations];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.springBounciness = 8;
    
    animation.toValue = [NSValue valueWithCGRect:baseRect];
    
    [animation setCompletionBlock:^(POPAnimation *animationCompleted, BOOL finished) {
        NSLog(@"terminou");
        
        CGRect baseRect = CGRectMake(button.frame.origin.x -0, button.frame.origin.y -5, button.frame.size.width, button.frame.size.height);
        
        [button pop_removeAllAnimations];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = 8;
        
        animation.toValue = [NSValue valueWithCGRect:baseRect];
        
        [button pop_addAnimation:animation forKey:@"fullscreen"];
        
        [someBlock invoke];
    }];
    
    [button pop_addAnimation:animation forKey:@"fullscreen"];
}

- (IBAction)didTapSpecialAttack:(UITapGestureRecognizer *)sender {
    UIView *view = (UIView *)sender.view;
    
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    // verifica se cooldown ainda está em efeito
    LWFOTESpinningCooldown *ote = [[LWFOTESpinningCooldown alloc]init];
    [ote addObserver:self];
    NSArray *sameKindOtes = [player.oteQueue oteWithSameKind:ote];
    BOOL cooldownOn = sameKindOtes != nil && sameKindOtes.count > 0;
    
    if (!cooldownOn) {
        [player.oteQueue addOTE:ote];
        
        [LWFSoundPlayer play:LWFSoundTypeUIClick];
        
        [self animateOnPressButton:view completion:^{
            [player requestSpecialAttack];
        }];
    }
}

- (IBAction)didTapInventoryOverlay:(id)sender {
    LWFInventory *inventory = [LWFInventory sharedInventory];
    if ([inventory isOpen]) {
        [inventory hide];
        return;
    }
}
- (IBAction)didTapInventoryContainer:(id)sender {
    LWFInventory *inventory = [LWFInventory sharedInventory];
    [inventory hideItemDescriptionIfNeeded];
}

# pragma - mark: LWFOTEObserver

- (void)notify:(LWFOTE *)ote turnsLeftChangedTo:(NSInteger)newTurnsLeft {
    NSLog(@"cooldown do spinning mudou para: %d", newTurnsLeft);
    
    [self updatePieView:newTurnsLeft forTotalTurns:ote.numberOfTurns];
}


/**
 pieView é a view indicadora de progresso do ataque especial
 esse método calcula o progresso/adiciona/remove
 */
- (void)updatePieView:(NSInteger)turnsLeft forTotalTurns:(NSInteger)totalTurns {
    
    BOOL playerIsAlive = [[LWFPlayer sharedPlayer] isAlive];
    
    if (turnsLeft == 0) {
        [self.pieView removeFromSuperview];
        self.pieView = nil;
        self.labelSpecialAttackCooldown.text = @"";
        return;
    }
    
    if (self.pieView == nil && playerIsAlive) {
        CGRect specialButtonFrame = self.viewSpecialAttackButton.frame;
        CGRect pieFrame = CGRectMake(30, 30, specialButtonFrame.size.width + 30, specialButtonFrame.size.height + 30);
        
        self.pieView = [[LWFPieView alloc]initWithFrame:pieFrame];
        
        self.pieView.backgroundColor = [UIColor blackColor];
        self.pieView.alpha = 0.5;
        
        self.pieView.center = CGPointMake(30, 30);
        self.viewSpecialAttackButton.clipsToBounds = YES;

        [self.viewSpecialAttackButton addSubview:self.pieView];
        [self.viewSpecialAttackButton bringSubviewToFront:self.labelSpecialAttackCooldown];
    }
    
    if (playerIsAlive) {
       self.labelSpecialAttackCooldown.text = [NSString stringWithFormat:@"%ld", (long)turnsLeft];
    }
    
    CGFloat progress = 1.0 - (float)turnsLeft / (float)totalTurns;
    self.pieView.progress = progress;
    [self.pieView setNeedsDisplay];
}

- (void)notifyRemovalOf:(LWFOTE *)ote {
    
}

- (void)notifyOTEActivated:(LWFOTE *)ote {
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
