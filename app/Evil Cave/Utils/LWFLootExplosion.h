//
//  LWFLootExplosion.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/10/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFTile;

@interface LWFLootExplosion : NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) LWFTile *tile;

- (instancetype)initWithItems:(NSArray *)items atTile:(LWFTile *)tile;
- (void)explodeWithCompletion:(void(^)(void))someBlock;

@end
