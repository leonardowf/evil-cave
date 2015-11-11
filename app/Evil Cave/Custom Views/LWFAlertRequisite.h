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

@end

@interface LWFViewController()
@property (nonatomic, strong) LWFAlertRequisite *alertRequisite;
@end

@interface LWFViewController (AlertRequisite)
- (void)openAlertForRequisite:(LWFRequisite *)requisite;
@end

