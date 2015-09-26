//
//  LWFOTEQueue.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFOTEObserver.h"

@interface LWFOTEQueue : NSObject

- (void)process;
- (NSArray *)oteWithSameKind:(LWFOTE *)ote;
- (void)addOTE:(LWFOTE *)ote;
- (void)removeAll;
- (NSArray *)oteWithSameClass:(Class)clazz;
@end
