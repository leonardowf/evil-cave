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
    NSMutableArray *itemClones = [NSMutableArray array];
    
    NSMutableArray *actions = [NSMutableArray array];
    
    for (LWFItem *item in _items) {
        NSInteger randomIndex = [randomUtils randomIntegerBetween:1 and:tilesToLoot.count];
        
        LWFTile *tile = [tilesToLoot objectAtIndex:randomIndex];
        [tilesInOrder addObject:tile];
        
        SKSpriteNode *itemClone = [SKSpriteNode spriteNodeWithTexture:item.texture];
        itemClone.size = CGSizeMake(TILE_SIZE, TILE_SIZE);
        
        itemClone.position = _tile.position;
        [map addChild:itemClone];
        
        [itemClones addObject:itemClone];
        
        CGPoint origin = _tile.position;
        CGPoint dest = tile.position;
        
        CGVector vector = CGVectorMake(dest.x, dest.y);
        
        SKAction *action = [SKEase MoveToWithNode:itemClone EaseFunction:CurveTypeSine Mode:EaseOut Time:0.2 ToVector:vector];
        
        SKAction *scale = [SKEase ScaleToWithNode:itemClone EaseFunction:CurveTypeSine Mode:EaseInOut Time:action.duration/2.0 ToValue:1.5];
        
        SKAction *scaleBack = [SKEase ScaleToWithNode:itemClone EaseFunction:CurveTypeSine Mode:EaseInOut Time:action.duration/2.0 ToValue:1.0];
        
        SKAction *scaleSeq = [SKAction sequence:@[scale, scaleBack]];
        
        action = [SKAction group:@[action, scaleSeq]];
        
        [actions addObject:action];
    }

    for (NSInteger i = 0; i < tilesInOrder.count; i++) {
        LWFTile *tile = [tilesInOrder objectAtIndex:i];
        SKAction *action = [actions objectAtIndex:i];
        LWFItem *item = [_items objectAtIndex:i];
        SKSpriteNode *itemClone = [itemClones objectAtIndex:i];
        
        [itemClone runAction:action completion:^{
            [tile addLoot:@[item] animated:NO];
            [itemClone removeFromParent];
            
        }];
    }
    
    [someBlock invoke];
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
