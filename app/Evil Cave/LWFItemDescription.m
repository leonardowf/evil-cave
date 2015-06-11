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
#import <pop/POP.h>

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
            
            if ([_inventory canUnequip:_equipment]) {
                [self.buttonEquip setEnabled:YES];
            } else {
                [self.buttonEquip setEnabled:NO];
            }
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
    self.labelTitle.text = [_equipment getName];
    
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

- (IBAction)didTapEquip:(id)sender {
    if ([_inventory isEquipped:_equipment]) {
        // apertou no botão amarelo de unequip
        if ([_inventory canUnequip:_equipment]) {
            [_inventory unequip:_equipment];
            [self removeFromSuperview:YES];
        }
    } else {
        [self removeFromSuperview:YES];
        [_inventory equip:_equipment];
    }
}

- (IBAction)didTapDrop:(id)sender {
    [self removeFromSuperview:true];
    [_inventory drop:_equipment];
}

- (UIView *)getContainerView {
    return self.containerView;
}

- (UIView *)getView {
    return self.view;
}

- (NSString *)getNibName {
    return @"ItemDescription";
}

@end
