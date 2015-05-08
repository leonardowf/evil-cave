//
//  LWFItemDescription.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/11/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemDescription.h"
#import "LWFInventory.h"
#import "LWFItemComparison.h"
#import "LWFEquipment.h"

@interface LWFItemDescription () {
    CGSize _intrinsic;
}

@end

@interface LWFItemDescription () {
    LWFEquipment *_equipment;
    LWFInventory *_inventory;
    LWFItemComparison *_itemComparison;
}
@end

@implementation LWFItemDescription

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addOutlineToLabel:self.labelTitle];
    }
    return self;
}

- (instancetype)initWithItem:(LWFEquipment *)equipment
              itemComparison:(LWFItemComparison *)itemComparison
                andInventory:(LWFInventory *)inventory
{
    self = [self init];
    if (self) {
        _equipment = equipment;
        _inventory = inventory;
        _itemComparison = itemComparison;
        
        [self fillLabels];
    
        if ([_inventory isEquipped:_equipment]) {
            UIImage *buttonImage = [UIImage imageNamed:@"button_yellow"];
            [self.buttonEquip setBackgroundImage:buttonImage forState:UIControlStateNormal];
            [self.buttonEquip setTitle:@"UNEQUIP" forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)addOutlineToLabel:(UILabel *)label {
    UIColor *aColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:125/2550 alpha:1];
    
    label.layer.shadowColor = [aColor CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.layer.shadowOpacity = 1.0f;
    label.layer.shadowRadius = 1.0f;
}

- (void)fillLabels {
    self.labelTitle.text = _equipment.name;
    
    [self fillForNumber:_equipment.strength label:self.labelStrength comparison:_itemComparison.strength andPrefix:@"Strength"];
    [self fillForNumber:_equipment.lowdamage label:self.labelMinDamage comparison:_itemComparison.minimumDamage andPrefix:@"Min Damage"];
    [self fillForNumber:_equipment.highdamage label:self.labelMaxDamage comparison:_itemComparison.maximumDamage andPrefix:@"Max Damage"];
    [self fillForNumber:_equipment.HP label:self.labelHp comparison:_itemComparison.hp andPrefix:@"HP"];
}

- (void)fillForNumber:(NSNumber *)number label:(UILabel *)label comparison:(NSInteger)comparison andPrefix:(NSString *)prefix {
    if (number != nil && [number integerValue] != 0) {
        if (comparison != 0) {
            
            NSAttributedString *atrString = [self buildString:comparison prefix:prefix number:number];
            label.attributedText = atrString;
            
        } else {
            label.text = [NSString stringWithFormat:@"%@: %@", prefix, [number stringValue]];
        }
    } else {
        if (comparison == 0) {
            [self hideLabel:label];
        } else {
            NSAttributedString *atrString = [self buildString:comparison prefix:prefix number:@(0)];
            label.attributedText = atrString;
        }
    }
}

- (NSAttributedString *)buildString:(NSInteger)comparison prefix:(NSString *)prefix number:(NSNumber *)number {
    NSString *numberStr = comparison < 0 ? [@(comparison) stringValue] : [NSString stringWithFormat:@"+%ld", comparison];
    NSString *comparisonResultString = [NSString stringWithFormat:@" (%@)", numberStr];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:comparisonResultString];
    
    UIColor *color = comparison > 0 ? [UIColor greenColor] : [UIColor redColor];
    
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attrString.length)];
    
    NSString *normalString = [NSString stringWithFormat:@"%@: %@", prefix, [number stringValue]];
    NSMutableAttributedString *concatenated = [[NSMutableAttributedString alloc]initWithString:normalString];
    [concatenated appendAttributedString:attrString];
    
    return concatenated;
}

- (void)hideLabel:(UILabel *)label {
    label.text = @"";
    
    for (NSLayoutConstraint *con in self.containerView.constraints) {
        if (con.firstItem == label && con.firstAttribute == NSLayoutAttributeTop) {
            con.constant = 0.0;
            return;
        }

    }
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"ItemDescription" owner:self options:nil];
        self.bounds = self.containerView.bounds;
        [self addSubview:self.view];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"ItemDescription" owner:self options:nil];
        [self addSubview:self.view];
        _intrinsic = self.view.bounds.size;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return _intrinsic;
}

- (void)addToView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:self.containerView];
    
    NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-60];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:60];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [view addConstraint:c0];
    [view addConstraint:c1];
    [view addConstraint:c2];
    
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.3];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[self.containerView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
}

- (void)removeFromSuperview:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.4
                         animations:^{self.alpha = 0.0;}
                         completion:^(BOOL finished){ [self.containerView removeFromSuperview]; }];
    } else {
        [self.containerView removeFromSuperview];
    }
}

- (IBAction)didTapEquip:(id)sender {
    if ([_inventory isEquipped:_equipment]) {
        // apertou no botão amarelo de unequip
        [_inventory unequip:_equipment];
        [self removeFromSuperview:YES];
    } else {
        [self removeFromSuperview:YES];
        [_inventory equip:_equipment];
    }
}

- (IBAction)didTapDrop:(id)sender {
    [self removeFromSuperview:true];
    [_inventory drop:_equipment];
}

@end
