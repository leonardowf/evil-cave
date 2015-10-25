//
//  LWFSkillTreeController.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/19/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillTreeController.h"
#import "LWFSkillTree.h"
#import "LWFSkillView.h"

@interface LWFSkillTreeController () {
    NSArray *_skillViews;
}
@end

@implementation LWFSkillTreeController

- (NSArray *)loadSkillViews {
    NSMutableArray *views = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= LWFSkillTypeCount; i++) {
        LWFSkillView *skillView = (LWFSkillView *)[self.skillViewContainer viewWithTag:i];
        skillView.skillType = i-1;
        
        [views addObject:skillView];
    }
    
    return views;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _skillViews = [self loadSkillViews];
    
    [self render];
}

- (void)render {
    for (LWFSkillView *skillView in _skillViews) {
        [skillView render];
    }
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
