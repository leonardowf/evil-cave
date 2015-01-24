//
//  LWFGameController.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/17/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFMap;
@class LWFTileMap;
@class LWFTurnList;
@class LWFCreatureBuilder;
@class LWFAttacksBuilder;
@class LWFItemPrototypeFactory;

@interface LWFGameController : NSObject

@property (nonatomic, strong) LWFTileMap *tileMap;
@property (nonatomic, strong) LWFItemPrototypeFactory *itemPrototypeFactory;

+ (id)sharedGameController;

@end
