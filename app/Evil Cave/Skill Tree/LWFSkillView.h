//
//  LWFSkillView.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/20/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWFSkillTree.h"

@interface LWFSkillView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (nonatomic) LWFSkillType skillType;

- (void)render;

@end
