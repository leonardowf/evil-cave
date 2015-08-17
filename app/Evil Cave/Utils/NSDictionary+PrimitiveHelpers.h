//
//  NSDictionary_NSDictionary_PrimitiveHelpers.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PrimitiveHelpers)
- (CGFloat)floatForKey:(NSString *)key;
- (BOOL)booleanForKey:(NSString *)key;
@end

@implementation NSDictionary (PrimitiveHelpers)
- (CGFloat)floatForKey:(NSString *)key {
    NSNumber *floatNumber = [self objectForKey:key];
    return [floatNumber floatValue];
}

- (BOOL)booleanForKey:(NSString *)key {
    NSNumber *booleanNumber = [self objectForKey:key];
    return [booleanNumber boolValue];
}

@end
