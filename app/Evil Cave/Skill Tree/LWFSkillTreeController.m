//
//  LWFSkillTreeController.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/19/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillTreeController.h"
#import "LWFSkillTree.h"
#import "LWFInventory.h"

@interface LWFSkillTreeController () {
    NSArray *_skillViews;
    LWFSkillTree *_skillTree;
    LWFSkillType _currentSelectedSkillType;
    LWFInventory *_inventory;
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
    
    // usamos a última posição do enum de tipo de skill como nil
    _currentSelectedSkillType = LWFSkillTypeCount;
    
    _skillViews = [self loadSkillViews];
    _skillTree = [LWFSkillTree sharedSkillTree];
    _inventory = [LWFInventory sharedInventory];
    
    [self render];
}

- (void)render {
    for (LWFSkillView *skillView in _skillViews) {
        [skillView render];
    }
    
    if ([self shouldHideBuyButton]) {
        self.buyButton.hidden = YES;
    } else {
        self.buyButton.hidden = NO;
    }
    
    self.goldLabel.text = [NSString stringWithFormat:@"Gold: %d", _inventory.money];
}

- (BOOL)shouldHideBuyButton {
    if (_currentSelectedSkillType == LWFSkillTypeCount) {
        return YES;
    }
    
    if ([_skillTree canRaiseSkill:_currentSelectedSkillType withTotalMoney:_inventory.money]) {
        return NO;
    }
    
    return YES;
}

- (void)renderDescription:(LWFSkillType)skillType {
    self.skillDescriptionLabel.text = [_skillTree descriptionForSkill:_currentSelectedSkillType];
    
    self.skillNameLabel.text = [_skillTree nameForSkill:_currentSelectedSkillType];
}

- (IBAction)didTapBuy:(UIButton *)sender {
    if ([_skillTree canRaiseSkill:_currentSelectedSkillType withTotalMoney:_inventory.money]) {
        
        NSInteger nextPrice = [_skillTree nextPriceForSkillType:_currentSelectedSkillType];
        
        [_skillTree raiseSkill:_currentSelectedSkillType];
        
        _inventory.money -= nextPrice;
    }
    
    [self render];
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didTapSkillWithType:(LWFSkillType)skillType {
    _currentSelectedSkillType = skillType;
    
    [self render];
    [self renderDescription:skillType];
}


@end
