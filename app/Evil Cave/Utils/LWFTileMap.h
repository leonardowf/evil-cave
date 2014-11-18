//
//  LWFTileMap.h
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWFMapDimension;
@class LWFTile;

@interface LWFTileMap : NSObject

@property (nonatomic, strong) NSMutableArray *tiles;
@property (nonatomic, strong) NSMutableArray *gridModel;

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension;
- (LWFTile *)tileForVertical:(NSInteger)vertical andHorizontal:(NSInteger)horizontal;

@end
