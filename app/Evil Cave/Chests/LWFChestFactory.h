//
//  LWFChestFactory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFChestFactory : NSObject

@property (nonatomic, strong) NSArray *chestChances;

+ (id) sharedChestFactory;
- (NSArray *)getChestsForFloor:(NSInteger)floor;

@end
