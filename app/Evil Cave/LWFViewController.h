//
//  LWFViewController.h
//  Evil Cave
//

//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface LWFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *itemPreview;
@property (weak, nonatomic) IBOutlet UILabel *labelDamage;
@property (weak, nonatomic) IBOutlet UILabel *labelStrength;
@property (weak, nonatomic) IBOutlet UILabel *labelHP;
@property (weak, nonatomic) IBOutlet UILabel *labelArmor;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewItemSprite;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;


// inventory
@property (weak, nonatomic) IBOutlet UIImageView *imageViewInventoryBackground;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewWeapon;


@end
