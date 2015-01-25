//
//  LWFLootChanceFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/25/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLootChanceFactory.h"
#import "LWFLootChance.h"
#import "LWFItemPrototypeFactory.h"

@interface LWFLootChanceFactory () {
    LWFItemPrototypeFactory *_itemPrototypeFactory;
}

@end

@implementation LWFLootChanceFactory

SINGLETON_FOR_CLASS(LootChanceFactory)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemPrototypeFactory = [LWFItemPrototypeFactory sharedItemPrototypeFactory];
        [self loadFromJson];
    }
    return self;
}

- (void)loadFromJson {
    NSDictionary *jsonChances = [self getDictionaryFromJson];
    NSMutableDictionary *lootChances = [NSMutableDictionary dictionary];
    
    for (NSString *key in jsonChances) {
        NSArray *lootChancesJson = [jsonChances objectForKey:key];
        NSMutableArray *lootChancesForKey = [NSMutableArray array];
        
        for (NSDictionary *dict in lootChancesJson) {
            LWFLootChance *lootChance = [[LWFLootChance alloc]initWithDictionary:dict];
            LWFItemPrototype *prototype = [_itemPrototypeFactory getPrototypeWithName:lootChance.name];
            lootChance.prototype = prototype;
            [lootChancesForKey addObject:lootChance];
        }
        
        [lootChances setObject:lootChancesForKey forKey:key];
    }
    
    self.lootChances = lootChances;
}

- (NSDictionary *)getDictionaryFromJson {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loot_chances"
                                                         ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSData *jsonData = [myJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDataDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:kNilOptions error:&error];
    
    return jsonDataDict;
}



@end
