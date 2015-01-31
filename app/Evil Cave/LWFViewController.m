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
    
}

- (void)configureEvents {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(steppedOnItemNotification:)
                                                 name:@"steppedOnTileNotification"
                                               object:nil];
}

- (void)steppedOnItemNotification:(NSNotification *)notification {
    NSMutableArray *itemsStepped = [notification object];
    
    if (itemsStepped == nil || itemsStepped.count == 0) {
        self.itemPreview.alpha = 0;
        self.itemPreview.hidden = YES;
    } else {
        self.itemPreview.alpha = 1.0;
        self.itemPreview.hidden = NO;
        
        LWFItem *item = [itemsStepped lastObject];
        
        self.labelName.text = item.name;
        self.labelDamage.text = [item damageText];
        self.labelHP.text = [item hpText];
        self.labelStrength.text = [item strengthText];
        self.labelArmor.text = [item armorText];
        
        [self.view layoutIfNeeded];
        
        self.topConstraint.constant = 0;
        [UIView animateWithDuration:5
                         animations:^{
                             [self.view layoutIfNeeded]; // Called on parent view
                         }];
        
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


@end
