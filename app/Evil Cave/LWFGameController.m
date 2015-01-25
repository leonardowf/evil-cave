//
//  LWFGameController.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/17/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFGameController.h"
#import "LWFItemPrototypeFactory.h"
#import "LWFLootChanceFactory.h"

@implementation LWFGameController

SINGLETON_FOR_CLASS(GameController)


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemPrototypeFactory = [LWFItemPrototypeFactory sharedItemPrototypeFactory];
        self.lootChanceFactory = [LWFLootChanceFactory sharedLootChanceFactory];
    }
    return self;
}
@end
