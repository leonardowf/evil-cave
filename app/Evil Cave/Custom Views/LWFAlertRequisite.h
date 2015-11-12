//
//  LWFAlertRequisite.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/9/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWFViewController.h"
#import "LWFRequisite.h"

@interface LWFAlertRequisite : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *buttonCloseImageView;

@property (nonatomic, strong) LWFRequisite *requisite;

- (void)render;

@end