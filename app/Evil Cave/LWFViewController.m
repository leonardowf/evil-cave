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

#import "QuartzCore/QuartzCore.h"
#import <pop/POP.h>
#import "LWFTutorial.h"

@implementation LWFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.viewTutorial setDelegate:self];    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.viewTutorial showTutorialIfNeeded];
}

- (void)tutorialFinished {
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
}

- (void)configureEvents {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(notificationShowItemPreview:)
//                                                 name:@"notificationShowItemPreview"
//                                               object:nil];
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
        
        LWFNewItem *item = [itemsStepped lastObject];
        
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
    
    CGRect baseRect = CGRectMake(view.frame.origin.x + 0, view.frame.origin.y + 5, view.frame.size.width, view.frame.size.height);
    
    [view pop_removeAllAnimations];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.springBounciness = 8;
    
    animation.toValue = [NSValue valueWithCGRect:baseRect];
    [animation setCompletionBlock:^(POPAnimation *animationCompleted, BOOL finished) {
        NSLog(@"terminou");
        
        CGRect baseRect = CGRectMake(view.frame.origin.x -0, view.frame.origin.y -5, view.frame.size.width, view.frame.size.height);
        
        [view pop_removeAllAnimations];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = 8;
        
        animation.toValue = [NSValue valueWithCGRect:baseRect];
        
        [view pop_addAnimation:animation forKey:@"fullscreen"];
        
        LWFInventory *inventory = [LWFInventory sharedInventory];
        [inventory show];
    }];
    
    [view pop_addAnimation:animation forKey:@"fullscreen"];
}

- (IBAction)didTapSpecialAttack:(id)sender {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    // verifica se cooldown ainda está em efeito
    LWFOTESpinningCooldown *ote = [[LWFOTESpinningCooldown alloc]init];
    [ote addObserver:self];
    NSArray *sameKindOtes = [player.oteQueue oteWithSameKind:ote];
    BOOL cooldownOn = sameKindOtes != nil && sameKindOtes.count > 0;
    
    if (!cooldownOn) {
        [player.oteQueue addOTE:ote];
        [player requestSpecialAttack];
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
    
    if (newTurnsLeft == 0) {
        self.labelSpecialAttackCooldown.text = @"";
    } else {
        self.labelSpecialAttackCooldown.text = [NSString stringWithFormat:@"%d", newTurnsLeft];
    }
}

- (void)notifyRemovalOf:(LWFOTE *)ote {
    
}

- (void)notifyOTEActivated:(LWFOTE *)ote {
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
