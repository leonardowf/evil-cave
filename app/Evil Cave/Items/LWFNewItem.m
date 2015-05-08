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

- (UIImage *)getImage {
    UIImage *itemImage = [UIImage imageNamed:[NSString stringWithFormat:@"item_%@", self.imageName]];
    
    return itemImage;
}

@end
