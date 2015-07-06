//
//  LWFChestChance.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/5/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFChestChance : NSObject

@property (nonatomic) NSInteger floor;
@property (nonatomic) CGFloat chance;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSArray *lootChances;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSInteger)amountRespawned;
@end
