//
//  LWFUserDefaultsPersistenceStrategy.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFPersistenceStrategy.h"

@interface LWFUserDefaultsPersistenceStrategy : NSObject <LWFPersistenceStrategy>

- (void)saveDictionary:(NSDictionary *)dictionary atKey:(NSString *)key;
- (void)saveString:(NSString *)string atKey:(NSString *)key;

- (NSDictionary *)loadDictionaryAtKey:(NSString *)key;
- (NSString *)loadStringAtKey:(NSString *)key;

@end
