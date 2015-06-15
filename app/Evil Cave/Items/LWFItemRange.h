//
//  LWFItemRange.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/15/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class LWFTile;

@interface LWFItemRange : NSObject

@property (nonatomic, strong) NSMutableArray *tiles;

- (instancetype)initFromTile:(LWFTile *)tile;

@end
