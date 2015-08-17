//
//  LWFMockPersistanceStrategy.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFMockPersistanceStrategy.h"

@interface LWFMockPersistanceStrategy () {
    NSMutableDictionary *_dataStorage;
}

@end

@implementation LWFMockPersistanceStrategy

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataStorage = [NSMutableDictionary new];
    }
    return self;
}

- (void)saveDictionary:(NSDictionary *)dictionary atKey:(NSString *)key {
    [_dataStorage setObject:dictionary forKey:key];
}

- (void)saveString:(NSString *)string atKey:(NSString *)key {
    [_dataStorage setObject:string forKey:key];
}

- (NSDictionary *)loadDictionaryAtKey:(NSString *)key {
    return [_dataStorage objectForKey:key];
}

- (NSString *)loadStringAtKey:(NSString *)key {
    return [_dataStorage objectForKey:key];
}

@end
