//
//  LWFSkillTreeController.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/19/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillTreeController.h"
#import "LWFSkillTree.h"

@interface LWFSkillTreeController () {
    NSArray *_skillViews;
    LWFSkillTree *_skillTree;
    LWFSkillType _currentSelectedSkillType;
}
@end

@implementation LWFSkillTreeController

- (NSArray *)loadSkillViews {
    NSMutableArray *views = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= LWFSkillTypeCount; i++) {
        LWFSkillView *skillView = (LWFSkillView *)[self.skillViewContainer viewWithTag:i];
        skillView.skillType = i - 1;
        skillView.delegate = self;
        
        [views addObject:skillView];
    }
    
    return views;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _skillViews = [self loadSkillViews];
    _skillTree = [LWFSkillTree sharedSkillTree];
    
    [self render];
}

- (void)render {
    for (LWFSkillView *skillView in _skillViews) {
        [skillView render];
    }
}

- (void)renderDescription:(LWFSkillType)skillType {
    
    
    self.skillDescriptionLabel.text = [_skillTree descriptionForSkill:_currentSelectedSkillType];
    
    self.skillNameLabel.text = [_skillTree nameForSkill:_currentSelectedSkillType];
}

- (IBAction)didTapBuy:(UIButton *)sender {
    [_skillTree raiseSkill:_currentSelectedSkillType];
    
    [self render];
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didTapSkillWithType:(LWFSkillType)skillType {
    _currentSelectedSkillType = skillType;
    
    [self renderDescription:skillType];
}


@end
