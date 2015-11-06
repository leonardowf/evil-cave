//
//  LWFPlayerStats.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/4/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWFPlayerStats : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *buttonCloseImageView;

@property (weak, nonatomic) IBOutlet UILabel *hpLabel;
@property (weak, nonatomic) IBOutlet UILabel *strengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *armorLabel;
@property (weak, nonatomic) IBOutlet UILabel *potionEffectLabel;
@property (weak, nonatomic) IBOutlet UILabel *lootChanceLabel;

- (void)render;

@end
