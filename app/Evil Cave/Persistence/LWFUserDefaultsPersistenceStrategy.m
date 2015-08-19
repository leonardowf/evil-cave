//
//  LWFUserDefaultsPersistenceStrategy.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFUserDefaultsPersistenceStrategy.h"

@interface LWFUserDefaultsPersistenceStrategy () {
    NSUserDefaults *_userDefaults;
}
@end

@implementation LWFUserDefaultsPersistenceStrategy

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)saveDictionary:(NSDictionary *)dictionary atKey:(NSString *)key {
    [_userDefaults setObject:dictionary forKey:key];
    [_userDefaults synchronize];
}

- (void)saveString:(NSString *)string atKey:(NSString *)key {
    [_userDefaults setObject:string forKey:key];
    [_userDefaults synchronize];
}

- (NSDictionary *)loadDictionaryAtKey:(NSString *)key {
    return [_userDefaults objectForKey:key];
}

- (NSString *)loadStringAtKey:(NSString *)key {
    return [_userDefaults objectForKey:key];
}

@end
