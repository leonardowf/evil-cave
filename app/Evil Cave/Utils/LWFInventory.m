//
//  LWFInventory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFInventory.h"
#import "LWFItem.h"

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
    
}

- (void)show {
    
}

- (BOOL)canTakeItem:(LWFItem *)item {
    return YES;
    // TODO
}
@end
