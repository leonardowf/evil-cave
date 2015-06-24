//
//  LWFPotionDescription.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LWFNewItemDescription.h"
@class LWFPotion;
@class LWFInventory;

@interface LWFPotionDescription : LWFNewItemDescription
@property (weak, nonatomic) IBOutlet UILabel *labelPotionName;
@property (weak, nonatomic) IBOutlet UILabel *labelPotionDescription;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (instancetype)initWithItem:(LWFPotion *)potion
                andInventory:(LWFInventory *)inventory;

@end
