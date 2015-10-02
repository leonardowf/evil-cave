//
//  LWFLootExplosion.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/10/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLootExplosion.h"
#import "LWFTile.h"
#import "LWFGameController.h"
#import "LWFTileMap.h"
#import "LWFRandomUtils.h"
#import "LWFMap.h"
#import "LWFItem.h"
#import "SKEase.h"

@interface LWFLootExplosion () {
    LWFGameController *_gameController;
}
@end

@implementation LWFLootExplosion

- (instancetype)initWithItems:(NSArray *)items atTile:(LWFTile *)tile;
{
    self = [super init];
    if (self) {
        self.items = items;
        self.tile = tile;
        
        _gameController = [LWFGameController sharedGameController];
    }
    return self;
}

- (void)explodeWithCompletion:(void(^)(void))someBlock {
    NSMutableArray *tilesToLoot = [NSMutableArray arrayWithArray:[self getAvailableTilesForLoot]];
    NSMutableArray *tilesInOrder = [NSMutableArray array];
    LWFRandomUtils *randomUtils = [LWFRandomUtils new];
    LWFMap *map = _gameController.map;
    
    for (NSInteger i = 0; i < _items.count; i++) {
        NSInteger randomIndex = [randomUtils randomIntegerBetween:1 and:tilesToLoot.count];
        
        LWFTile *tile = [tilesToLoot objectAtIndex:randomIndex];
        [tilesInOrder addObject:tile];
    }
    
    NSDictionary *itemsGroupedByTile = [self groupByTiles:tilesInOrder items:_items];
    
    NSSet *tilesSet = [NSSet setWithArray:tilesInOrder];
    
    for (LWFTile *tile in tilesSet) {
        NSArray *items = itemsGroupedByTile[[tile toString]];
        for (LWFItem *item in items) {
            SKSpriteNode *itemClone = [self itemClone:item];
            [map addChild:itemClone];
            
            SKAction *action = [self getExplosionAnimation:itemClone destinationTile:tile];
            
            [itemClone runAction:action completion:^{
                [tile addLoot:@[item] animated:NO];
                [itemClone removeFromParent];
            }];
        }
    }
    
    [someBlock invoke];
}

- (SKSpriteNode *)itemClone:(LWFItem *)item {
    SKSpriteNode *itemClone = [SKSpriteNode spriteNodeWithTexture:item.texture];
    itemClone.size = CGSizeMake(TILE_SIZE, TILE_SIZE);
    
    itemClone.position = _tile.position;
    
    return itemClone;
}

- (NSDictionary *)groupByTiles:(NSArray *)tiles items:(NSArray *)items {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for (LWFTile *tile in tiles) {
        dictionary[[tile toString]] = [NSMutableArray array];
    }
    
    for (NSInteger i = 0; i < tiles.count; i++) {
        LWFTile *tile = tiles[i];
        LWFItem *item = items[i];
        NSMutableArray *array = dictionary[[tile toString]];
        
        LWFItem *itemToStack = [self findWithSameKindOfItem:item inArray:array];
        
        if (itemToStack == nil) {
            [array addObject:item];
        } else {
            itemToStack.quantity += item.quantity;
        }
    }
    
    return dictionary;
}

- (LWFItem *)findWithSameKindOfItem:(LWFItem *)item inArray:(NSArray *)array {
    for (LWFItem *itemInArray in array) {
        if ([itemInArray canStackWith:item]) {
            return itemInArray;
        }
    }
    
    return nil;
}

- (SKAction *)getExplosionAnimation:(SKSpriteNode *)item destinationTile:(LWFTile *)tile {
    LWFRandomUtils *randomUtils = [LWFRandomUtils new];
    CGFloat rotateCoefficient = [randomUtils randomFloatBetween:0 and:0.8];
    CGFloat multiplier = rotateCoefficient > 0.5 ? -1 : 1;
    
    CGPoint dest = tile.position;
    
    item.xScale = 1.5;
    item.yScale = 1.5;
    
    item.zRotation = rotateCoefficient * M_PI;
    
    CGVector vector = CGVectorMake(dest.x, dest.y);
    
    SKAction *action = [SKEase MoveToWithNode:item EaseFunction:CurveTypeSine Mode:EaseOut Time:0.6 ToVector:vector];
    
    SKAction *scale = [SKAction scaleBy:0.666 duration:action.duration/0.9];
    
    SKAction *scaleSeq = [SKAction sequence:@[scale]];
    
    SKAction *rotate = [SKAction rotateByAngle:(multiplier * 2 * M_PI - item.zRotation) duration:action.duration];
    
    action = [SKAction group:@[action, scaleSeq, rotate]];
    
    return action;
}

- (NSArray *)getAvailableTilesForLoot {
    LWFTileMap *tileMap = [_gameController tileMap];
    NSMutableArray *tiles = [NSMutableArray array];
    
    NSArray *neighbors = [tileMap neighborsForTile:self.tile];
    
    for (LWFTile *neighbor in neighbors) {
        if ([neighbor isPassable]) {
            [tiles addObject:neighbor];
        }
    }
    
    return tiles;
}

@end
