//
//  LWFLootable.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LWFLootable <NSObject>

- (NSArray *)getLootChances;
- (NSArray *)getLoots;

@end
