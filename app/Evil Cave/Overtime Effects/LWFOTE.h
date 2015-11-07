//
//  LWFOTE.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFOTEObserver.h"

@interface LWFOTE : NSObject

@property (nonatomic) NSInteger numberOfTurns;
@property (nonatomic) NSInteger turnsLeft;

- (instancetype)initWithNumberOfTurns:(NSInteger)numberOfTurns;

- (void)activate;
- (void)turnsLeftChanged;
- (void)willBeRemoved;
- (void)wasRemoved;

- (void)addObserver:(id<LWFOTEObserver>)observer;

@end
