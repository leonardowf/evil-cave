//
//  LWFViewController.h
//  Evil Cave
//

//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "LWFOTEObserver.h"
#import "LWFTutorial.h"
#import "LWFImageViewInventoryItem.h"

@class LWFTutorial;
@class LWFPieView;

@interface LWFViewController : UIViewController <LWFOTEObserver, LWFTutorialDelegate>

@property (weak, nonatomic) IBOutlet UIView *itemPreview;
@property (weak, nonatomic) IBOutlet UILabel *labelDamage;
@property (weak, nonatomic) IBOutlet UILabel *labelStrength;
@property (weak, nonatomic) IBOutlet UILabel *labelHP;
@property (weak, nonatomic) IBOutlet UILabel *labelArmor;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewItemSprite;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@property (weak, nonatomic) IBOutlet LWFTutorial *viewTutorial;

// inventory
@property (weak, nonatomic) IBOutlet UIView *viewInventoryContainer;
@property (weak, nonatomic) IBOutlet UIView *viewInventoryOverlay;
@property (weak, nonatomic) IBOutlet UIView *viewInventoryButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewInventoryBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewWeapon;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewArmor;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBoots;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAccessory;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewWeaponBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewArmorBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBootsBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAccessoryBackground;

@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item1;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item2;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item3;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item4;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item5;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item6;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item7;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item8;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item9;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item10;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item11;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item12;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item13;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item14;
@property (weak, nonatomic) IBOutlet LWFImageViewInventoryItem *item15;

@property (weak, nonatomic) IBOutlet UILabel *labelGold;

// log
@property (weak, nonatomic) IBOutlet UIView *viewLogContainer;
@property (weak, nonatomic) IBOutlet UILabel *labelLogLine3;
@property (weak, nonatomic) IBOutlet UILabel *labelLogLine2;
@property (weak, nonatomic) IBOutlet UILabel *labelLogLine1;

// special attack
@property (weak, nonatomic) IBOutlet UILabel *labelSpecialAttackCooldown;
@property (weak, nonatomic) IBOutlet UIView *viewSpecialAttackButton;
@property (nonatomic, strong) LWFPieView *pieView;

@end
