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
    
    self.labelPotionName.text = [NSString stringWithFormat:@"%@ [x%d]", [_potion getName], _potion.quantity];
    return self;
    
}

- (IBAction)didTapDrinkButton:(id)sender {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    [_potion applyEffectOn:player];
    
    [_inventory didUsePotion:_potion];
}

- (IBAction)didTapThrowButton:(id)sender {
}

- (IBAction)didTapDropButton:(id)sender {
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
