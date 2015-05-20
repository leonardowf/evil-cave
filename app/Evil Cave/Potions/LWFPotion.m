//
//  LWFPotion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotion.h"

@implementation LWFPotion

- (BOOL)isPotion {
    return YES;
}

- (BOOL)isStackable {
    return YES;
}

- (BOOL)canStackWith:(LWFNewItem *)item {
    if ([item isPotion] && [item.identifier isEqualToString:self.identifier]) {
        return YES;
    }
    
    return NO;
}

@end
