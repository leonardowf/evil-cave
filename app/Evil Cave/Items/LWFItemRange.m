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

@implementation LWFItemRange

- (instancetype)initFromTile:(LWFTile *)tile
{
    self = [super init];
    if (self) {
        LWFVisibilityShadowCasting *vsc = [[LWFVisibilityShadowCasting alloc]init];
        [vsc doFovStartX:tile.x startY:tile.y radius:3];
        
        NSArray *tiles = [vsc getVisibleTiles];
        NSSet *setOfTiles = [NSSet setWithArray:tiles];
        self.tiles = [NSMutableArray array];
        
        for (LWFTile *tile in setOfTiles) {
            if (tile.cellType != CaveCellTypeWall) {
                [self.tiles addObject:tile];
                SKSpriteNode *redNode = [SKSpriteNode spriteNodeWithColor:[SKColor orangeColor] size:CGSizeMake(TILE_SIZE, TILE_SIZE)];
                redNode.alpha = 0.2;
                
                [tile addChild:redNode];
            }
        }
        
    }
    return self;
}

@end
