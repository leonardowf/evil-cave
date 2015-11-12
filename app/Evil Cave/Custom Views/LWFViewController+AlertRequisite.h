//
//  LWFViewController+AlertRequisite.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFViewController.h"


@interface LWFViewController (AlertRequisite)
- (void)openAlertForRequisite:(LWFRequisite *)requisite;

@property (nonatomic, strong) LWFAlertRequisite *alertRequisite;
@end
