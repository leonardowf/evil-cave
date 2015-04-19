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
@property (weak, nonatomic) IBOutlet UIView *viewInventoryContainer;
@property (weak, nonatomic) IBOutlet UIView *viewInventoryOverlay;


@property (weak, nonatomic) IBOutlet UIImageView *imageViewInventoryBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewWeapon;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewArmor;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBoots;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAccessory;

@property (weak, nonatomic) IBOutlet UIImageView *item1;
@property (weak, nonatomic) IBOutlet UIImageView *item2;
@property (weak, nonatomic) IBOutlet UIImageView *item3;
@property (weak, nonatomic) IBOutlet UIImageView *item4;
@property (weak, nonatomic) IBOutlet UIImageView *item5;
@property (weak, nonatomic) IBOutlet UIImageView *item6;
@property (weak, nonatomic) IBOutlet UIImageView *item7;
@property (weak, nonatomic) IBOutlet UIImageView *item8;
@property (weak, nonatomic) IBOutlet UIImageView *item9;
@property (weak, nonatomic) IBOutlet UIImageView *item10;
@property (weak, nonatomic) IBOutlet UIImageView *item11;
@property (weak, nonatomic) IBOutlet UIImageView *item12;
@property (weak, nonatomic) IBOutlet UIImageView *item13;
@property (weak, nonatomic) IBOutlet UIImageView *item14;
@property (weak, nonatomic) IBOutlet UIImageView *item15;

@property (weak, nonatomic) IBOutlet UILabel *labelGold;

@property (weak, nonatomic) IBOutlet UILabel *labelLogLine3;
@property (weak, nonatomic) IBOutlet UILabel *labelLogLine2;
@property (weak, nonatomic) IBOutlet UILabel *labelLogLine1;

@end
