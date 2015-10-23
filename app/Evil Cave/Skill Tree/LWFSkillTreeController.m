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
        
        [views addObject:skillView];
    }
    
    return views;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
