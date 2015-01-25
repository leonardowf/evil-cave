//
//  LWFItemPrototypeFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemPrototypeFactory.h"
#import "LWFItemPrototype.h"
#import "LWFItem.h"

@implementation LWFItemPrototypeFactory

SINGLETON_FOR_CLASS(ItemPrototypeFactory)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadFromJson];
    }
    return self;
}

- (void)loadFromJson {
    NSArray *jsonPrototypes = [self getDictionaryFromJson];
    NSMutableDictionary *prototypes = [NSMutableDictionary dictionary];
    
    for (NSDictionary *jsonPrototype in jsonPrototypes) {
        LWFItemPrototype *itemPrototype = [[LWFItemPrototype alloc]initWithDictionary:jsonPrototype];
        [prototypes setObject:itemPrototype forKey:itemPrototype.name];
    }
    
    self.prototypes = prototypes;
}

- (LWFItemPrototype *)getPrototypeWithName:(NSString *)name {
    return [self.prototypes objectForKey:name];
}

- (NSArray *)getDictionaryFromJson {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"item_prototypes"
                                                         ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSData *jsonData = [myJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonDataDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:kNilOptions error:&error];
    
    return jsonDataDict;
}


@end
