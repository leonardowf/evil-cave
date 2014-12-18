//
//  LWFAttack.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFTile;
@class LWFTileMap;
@class LWFGameController;
@class LWFCreature;

@interface LWFAttack : NSObject

- (NSMutableArray *)tilesInRangeForTile:(LWFTile *)tile;
- (NSArray *)creaturesInRangeOfTile:(LWFTile *)tile;
- (BOOL)isCreature:(LWFCreature *)creature inRangeOfTile:(LWFTile *)tile;
- (NSMutableArray *)range;

@end
