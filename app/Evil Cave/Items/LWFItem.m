//
//  LWFNewItem.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItem.h"
#import "LWFItemPrototypeFactory.h"

@implementation LWFItem

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

- (BOOL)canStackWith:(LWFItem *)item {
    return NO;
}

- (LWFItem *)stackWithItem:(LWFItem *)item {
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

- (NSString *)getName {
    return self.name;
}

@end
