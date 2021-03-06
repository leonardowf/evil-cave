//
//  LWFPlayerStats.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/4/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFPlayerStats.h"
#import "LWFPlayer.h"
#import "LWFStats.h"

@implementation LWFPlayerStats

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"PlayerStats" owner:self options:nil];
        
        self.view.frame = self.bounds;
        [self addSubview:self.view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapClose)];
        
        [self.buttonCloseImageView addGestureRecognizer:tap];
    }
    return self;
}

- (void)didTapClose {
    NSLog(@"pegou evento");
    
    [self removeFromSuperview];
}

- (void)render {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    LWFStats *stats = player.stats;
    LWFSkillTree *skillTree = [LWFSkillTree sharedSkillTree];
    
    self.hpLabel.text = [NSString stringWithFormat:@"%d/%d", stats.currentHP, stats.maxHP];
    self.strengthLabel.text = [NSString stringWithFormat:@"%d", stats.strength];
    self.armorLabel.text = [NSString stringWithFormat:@"%d", stats.baseArmor];
    self.potionEffectLabel.text = [NSString stringWithFormat:@"+%d%%", [skillTree bonusForSkillType:LWFSkillTypePotionEffectUp]];
    self.lootChanceLabel.text = [NSString stringWithFormat:@"+%d%%", [skillTree bonusForSkillType:LWFSkillTypeLootPlus]];
}

@end
