//
//  LWFChestFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFChestFactory.h"

@implementation LWFChestFactory

SINGLETON_FOR_CLASS(ChestFactory)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadFromJson];
    }
    return self;
}

- (void)loadFromJson {
    NSDictionary *jsonChances = [self getDictionaryFromJson];
    NSMutableDictionary *chestChances = [NSMutableDictionary dictionary];
}

- (NSArray *)getLootChancesForKey:(NSString *)key {
    return nil;
}

- (NSDictionary *)getDictionaryFromJson {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chest_chances"
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
