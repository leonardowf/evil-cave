//
//  LWFOvertimeEffect.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/25/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LWFOvertimeEffect <NSObject>

- (NSInteger)numberOfTurns;
- (void)overtimeNotInEffectAnymore;
- (void)overtimeEffectChangedFrom:(NSInteger)before to:(NSInteger)after;

@end
