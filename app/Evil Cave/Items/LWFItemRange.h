//
//  LWFItemRange.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/15/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class LWFTile;
@class LWFItem;

@protocol LWFItemRangeProtocol <NSObject>
- (void)didSelectTileInRange:(LWFTile *)tile forItem:(LWFItem *)item;
@end

@interface LWFItemRange : NSObject

@property (nonatomic, strong) NSMutableArray *tiles;
@property (nonatomic, weak) id<LWFItemRangeProtocol>delegate;

- (instancetype)initFromTile:(LWFTile *)tile forItem:(LWFItem *)item;
- (void)removeRangeOverlay;
- (BOOL)tileIsOnRange:(LWFTile *)tile;
- (void)throwItemAtTile:(LWFTile *)tile;

@end
