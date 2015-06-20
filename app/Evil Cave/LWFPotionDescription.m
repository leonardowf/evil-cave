//
//  LWFPotionDescription.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotionDescription.h"
#import "LWFPotion.h"
#import "LWFInventory.h"

#import "LWFPlayer.h"


#import <pop/POP.h>

@interface LWFPotionDescription () {
    LWFInventory *_inventory;
    LWFPotion *_potion;
    CGSize _intrinsic;
}
@end

@implementation LWFPotionDescription

- (instancetype)initWithItem:(LWFPotion *)potion
                andInventory:(LWFInventory *)inventory {
    
    self = [super init];
    
    if (self) {
        _inventory = inventory;
        _potion = potion;
    }
    
    [self displayPotionInfo];
    return self;
    
}

- (void)displayPotionInfo {
    self.labelPotionName.text = [NSString stringWithFormat:@"%@ [x%d]", [_potion getName], _potion.quantity];
}


- (IBAction)didTapDrinkButton:(id)sender {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    [_potion applyEffectOn:player];
    
    [_inventory didUsePotion:_potion];
    
    [self displayPotionInfo];
    
    if (_potion.quantity <= 0) {
        [self removeFromSuperview:true];
    }
}

- (IBAction)didTapThrowButton:(id)sender {
    [_inventory requestThrowItem:_potion];
}

- (IBAction)didTapDropButton:(id)sender {
    [self removeFromSuperview:true];
    [_inventory drop:_potion];
}

- (UIView *)getContainerView {
    return self.containerView;
}

- (UIView *)getView {
    return self.view;
}

- (NSString *)getNibName {
    return @"PotionDescription";
}

@end
