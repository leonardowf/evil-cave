//
//  LWFLootChance.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFItemPrototype;
@class LWFNewItem;

@interface LWFLootChance : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) CGFloat chance;

@property (nonatomic, strong) LWFItemPrototype *prototype;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (NSInteger)amountDropped;
- (LWFNewItem *)buildWithQuantity:(NSInteger)quantity;

@end
