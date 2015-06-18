//
//  LWFItemRange.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/15/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItemRange.h"

#import "LWFTile.h"
#import "LWFTileMap.h"
#import "LWFVisibilityShadowCasting.h"

@interface LWFItemRange () {
    NSMutableArray *_addedNodes;
    LWFNewItem *_item;
}
@end

@implementation LWFItemRange

- (instancetype)initFromTile:(LWFTile *)tile forItem:(LWFNewItem *)item
{
    self = [super init];
    if (self) {
        LWFVisibilityShadowCasting *vsc = [[LWFVisibilityShadowCasting alloc]init];
        _item = item;
        
        [vsc doFovStartX:tile.x startY:tile.y radius:3];
        
        NSArray *tiles = [vsc getVisibleTiles];
        NSSet *setOfTiles = [NSSet setWithArray:tiles];
        _addedNodes = [NSMutableArray array];
        self.tiles = [NSMutableArray array];
        
        for (LWFTile *tile in setOfTiles) {
            if (tile.cellType != CaveCellTypeWall) {
                [self.tiles addObject:tile];
                SKSpriteNode *redNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(TILE_SIZE, TILE_SIZE)];
                redNode.alpha = 0.2;
                
                [tile addChild:redNode];
                [_addedNodes addObject:redNode];
            }
        }
        
    }
    return self;
}

- (void)throwItemAtTile:(LWFTile *)tile {
    [self removeRangeOverlay];
    [self.delegate didSelectTileInRange:tile forItem:_item];
}

- (BOOL)tileIsOnRange:(LWFTile *)tile {
    return [self.tiles containsObject:tile];
}

- (void)removeRangeOverlay {
    for (SKSpriteNode *node in _addedNodes) {
        [node removeFromParent];
    }
}

@end
