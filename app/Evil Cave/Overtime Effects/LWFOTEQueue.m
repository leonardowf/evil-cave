//
//  LWFOTEQueue.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFOTEQueue.h"
#import "LWFOTE.h"

@interface LWFOTEQueue () {
    NSMutableArray *_OTEs;
}
@end

@implementation LWFOTEQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _OTEs = [NSMutableArray array];
    }
    return self;
}

- (void)removeAll {
    [_OTEs removeAllObjects];
}

- (void)addOTE:(LWFOTE *)ote {
    [_OTEs addObject:ote];
}

- (void)process {
    for (LWFOTE *ote in _OTEs) {
        [ote activate];
        ote.turnsLeft--;
        [ote turnsLeftChanged];
    }
    
    [self cleanOTEs];
}

- (void)cleanOTEs {
    NSMutableArray *toRemove = [NSMutableArray array];
    
    for (LWFOTE *ote in _OTEs) {
        if (ote.turnsLeft <= 0) {
            [ote willBeRemoved];
            [toRemove addObject:ote];
        }
    }
    
    [_OTEs removeObjectsInArray:toRemove];
}

- (NSArray *)oteWithSameKind:(LWFOTE *)ote {
    return [self oteWithSameClass:[ote class]];
}

- (NSArray *)oteWithSameClass:(Class)clazz {
    NSMutableArray *foundOTES = [NSMutableArray array];
    
    for (LWFOTE *anOte in _OTEs) {
        if ([anOte isKindOfClass:clazz]) {
            [foundOTES addObject:anOte];
        }
    }
    
    return foundOTES;
}

@end
