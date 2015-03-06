//
//  LWFViewController.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFViewController.h"
#import "LWFMyScene.h"
#import "LWFItem.h"
#import "LWFPlayer.h"
#import "LWFInventory.h"

@implementation LWFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [LWFMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    [self configureEvents];
    
    LWFInventory *inventory = [LWFInventory sharedInventory];
    [inventory inject:self];
    
    [self.imageViewWeapon.layer setMinificationFilter:kCAFilterTrilinear];
    [self.imageViewWeapon.layer setMagnificationFilter:kCAFilterTrilinear];
}

- (void)configureEvents {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationShowItemPreview:)
                                                 name:@"notificationShowItemPreview"
                                               object:nil];
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
        
        self.labelName.text = item.name;
        self.labelDamage.text = [item damageText];
        self.labelHP.text = [item hpText];
        self.labelStrength.text = [item strengthText];
        self.labelArmor.text = [item armorText];
        
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

- (IBAction)didTapInventoryButton:(id)sender {
    LWFInventory *inventory = [LWFInventory sharedInventory];
    [inventory show];
}

- (IBAction)didTapSpecialAttack:(id)sender {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    [player requestSpecialAttack];
}

@end
