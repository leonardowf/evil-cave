//
//  LWFTile.h
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LWFCaveGeneratorConstants.h"
@class LWFCreature;
@class LWFChest;
@class LWFTileMap;

@interface LWFTile : SKSpriteNode

@property (getter = isWalkable, setter = setWalkable:) BOOL walkable;
@property NSInteger x;
@property NSInteger y;
@property LWFCreature *creatureOnTile;
@property (nonatomic) CaveCellType cellType;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic) BOOL isThereBloodAlready;
@property (nonatomic) BOOL doorIsOpen;
@property (nonatomic, strong) SKSpriteNode *fog;
@property (nonatomic, strong) LWFChest *chest;
@property (nonatomic, strong) LWFTileMap *tileMap;

@property (nonatomic, getter=isLit) BOOL lit;

- (BOOL)isPassable;
- (NSUInteger)distanceToTile:(LWFTile *)tile;
- (void)steppedOnTile:(LWFCreature *)creature;
- (void)diedOnTile:(LWFCreature *)creature;
- (void)addLoot:(NSArray *)loot animated:(BOOL)animated;
- (NSArray *)groupItemsForLoot:(NSArray *)loot;
- (NSString *)toString;

- (void)light;
- (void)displayFog;

@end
