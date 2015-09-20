//
//  LWFAttack.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFPointObject.h"
#import "LWFTile.h"
#import "LWFPointObject.h"
#import "LWFTileMap.h"
#import "LWFGameController.h"
#import "LWFVisibilityShadowCasting.h"
#import "LWFCreature.h"

@class LWFGameController;
@class LWFCreature;

@interface LWFAttack : NSObject

@property (nonatomic) NSUInteger minimumDamage;
@property (nonatomic) NSUInteger maximumDamage;
@property (nonatomic) NSInteger fovRadius;

- (NSMutableArray *)tilesInRangeForTile:(LWFTile *)tile;
- (NSArray *)creaturesInRangeOfTile:(LWFTile *)tile;
- (BOOL)isCreature:(LWFCreature *)creature inRangeOfTile:(LWFTile *)tile;
- (NSMutableArray *)range;
- (NSArray *)creaturesInAffectedRangeFromTile:(LWFTile *)tile;

@end
