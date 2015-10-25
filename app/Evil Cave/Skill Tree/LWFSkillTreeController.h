//
//  LWFSkillTreeController.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/19/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWFSkillView.h"

@interface LWFSkillTreeController : UIViewController <LWFSkillViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *skillViewContainer;

@end
