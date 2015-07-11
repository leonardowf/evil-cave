//
//  LWFLootExplosion.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/10/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFLootExplosion : NSObject

@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items;
- (void)explodeWithCompletion:(void(^)(void))someBlock;

@end
