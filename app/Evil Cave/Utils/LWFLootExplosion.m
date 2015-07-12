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
    NSArray *tilesToLoot = [self getAvailableTilesForLoot];
    
    
    
    [someBlock invoke];
}

- (NSArray *)getAvailableTilesForLoot {
    LWFTileMap *tileMap = [_gameController tileMap];
    NSMutableArray *tiles = [NSMutableArray array];
    
    NSArray *neighbors = [tileMap neighborsForTile:self.tile];
    
    for (LWFTile *neighbor in neighbors) {
        if ([neighbor isWalkable]) {
            [tiles addObject:neighbor];
        }
    }
    
    return tiles;
}

@end
