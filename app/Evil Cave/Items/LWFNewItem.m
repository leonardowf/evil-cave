//
//  LWFNewItem.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFNewItem.h"
#import "LWFItemPrototypeFactory.h"

@implementation LWFNewItem

@dynamic name;

- (BOOL)isPotion {
    return NO;
}

- (BOOL)isGold {
    return NO;
}

- (BOOL)isEquipment {
    return NO;
}

- (BOOL)isProjectile {
    return NO;
}

- (BOOL)isStackable {
    return NO;
}

- (BOOL)isUsable {
    return NO;
}

- (BOOL)canStackWith:(LWFNewItem *)item {
    return NO;
}

- (LWFNewItem *)stackWithItem:(LWFNewItem *)item {
    return nil;
}

- (void)use {
    if (![self isUsable]) {
        return;
    }
}

- (UIImage *)getImage {
    UIImage *itemImage = [UIImage imageNamed:[NSString stringWithFormat:@"item_%@", self.imageName]];
    
    return itemImage;
}

@end
