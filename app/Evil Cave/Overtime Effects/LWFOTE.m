//
//  LWFOTE.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFOTE.h"

@interface LWFOTE () {
    NSMutableArray *_oteObservers;
}
@end

@implementation LWFOTE

- (instancetype)init
{
    self = [super init];
    if (self) {
        _oteObservers = [NSMutableArray array];
    }
    return self;
}

- (void)turnsLeftChanged {
    
}

- (void)activate {
    
}

- (void)willBeRemoved {
    
}

- (void)addObserver:(id<LWFOTEObserver>)observer {
    [_oteObservers addObject:observer];
}

@end
