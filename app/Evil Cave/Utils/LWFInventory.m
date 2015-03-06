//
//  LWFInventory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFInventory.h"
#import "LWFItem.h"
#import "LWFViewController.h"

@interface LWFInventory () {
    LWFViewController *_viewController;
}

@end
@implementation LWFInventory



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.money = 0;
        self.items = [NSMutableArray array];
    }
    return self;
}

SINGLETON_FOR_CLASS(Inventory)

- (void)hide {
    _viewController.viewInventoryContainer.alpha = 0.0;
}

- (void)show {
    _viewController.viewInventoryContainer.alpha = 1.0;
    
    _viewController.labelGold.text = [NSString stringWithFormat:@"%ld", (long)self.money];
}

- (BOOL)canTakeItem:(LWFItem *)item {
    return YES;
    // TODO
}

- (void)inject:(LWFViewController *)viewController {
    _viewController = viewController;
}

- (BOOL)isOpen {
    return _viewController.viewInventoryContainer.alpha == 1.0;
}


@end
