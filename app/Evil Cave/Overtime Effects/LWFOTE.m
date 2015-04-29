//
//  LWFOTE.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFOTE.h"
#import "LWFOTEObserver.h"

@interface LWFOTE () {
    NSMutableArray *_oteObservers;
}
@end

@implementation LWFOTE

- (instancetype)initWithNumberOfTurns:(NSInteger)numberOfTurns
{
    self = [super init];
    if (self) {
        _oteObservers = [NSMutableArray array];
        _numberOfTurns = numberOfTurns;
        _turnsLeft = _numberOfTurns;
    }
    return self;
}

- (void)turnsLeftChanged {
    for (id<LWFOTEObserver> observer in _oteObservers) {
        [observer notify:self turnsLeftChangedTo:self.turnsLeft];
    }
}

- (void)activate {
    for (id<LWFOTEObserver> observer in _oteObservers) {
        [observer notifyOTEActivated:self];
    }
}

- (void)willBeRemoved {
    for (id<LWFOTEObserver> observer in _oteObservers) {
        [observer notifyRemovalOf:self];
    }
}

- (void)addObserver:(id<LWFOTEObserver>)observer {
    [_oteObservers addObject:observer];
}

@end
