//
//  LWFSkillView.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/20/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillView.h"
#import "LWFSkillTree.h"
#import "LWFInventory.h"

@interface LWFSkillView () {
    LWFSkillTree *_skillTree;
    LWFInventory *_inventory;
    
}
@end

@implementation LWFSkillView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"LWFSkillView" owner:self options:nil];
        
        self.view.frame = self.bounds;
        
        [self addSubview:self.view];
        
        _skillTree = [LWFSkillTree sharedSkillTree];
        _inventory = [LWFInventory sharedInventory];
    }
    return self;
}

- (void)awakeFromNib {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(didInteract)];
    
    [self addGestureRecognizer:tapGesture];
}

- (void)didInteract {
    [self.delegate didTapSkillWithType:self.skillType];
}

- (void)setAsUnavailable {
    self.alpha = 0.3;
}

- (void)render {
    NSInteger level = [_skillTree currentLevelForSkillType:self.skillType];
    NSInteger maximumLevel = [_skillTree maximumSkillLevel:self.skillType];
    
    if (level >= maximumLevel) {
        [self setAsUnavailable];
    }
    
    NSInteger priceToBuy = [_skillTree nextPriceForSkillType:self.skillType];
    NSInteger currentMoney = _inventory.money;
    
    if (priceToBuy > currentMoney) {
        [self setAsUnavailable];
    }
    
    self.levelLabel.text = [NSString stringWithFormat:@"%d / %d", level, maximumLevel];
}

@end
