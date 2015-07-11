//
//  LWFLootExplosion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/10/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLootExplosion.h"

@implementation LWFLootExplosion

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (void)explodeWithCompletion:(void(^)(void))someBlock {
    
    
    [someBlock invoke];
}

@end
