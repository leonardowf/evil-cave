//
//  LWFItemDescription.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/11/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWFItemDescription : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelMinDamage;
@property (weak, nonatomic) IBOutlet UILabel *labelMaxDamage;
@property (weak, nonatomic) IBOutlet UILabel *labelStrength;
@property (weak, nonatomic) IBOutlet UILabel *labelHp;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewEquip;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDrop;

- (void)configureTaps;

@end
