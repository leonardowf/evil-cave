//
//  LWFAttack.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/1/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFAttack.h"

@interface LWFAttack () {
    LWFGameController *_gameController;
    
}
@end

@implementation LWFAttack

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gameController = [LWFGameController sharedGameController];
        _fovRadius = 1;
    }
    return self;
}

- (NSMutableArray *)tilesInRangeForTile:(LWFTile *)tile {
    NSMutableArray *range = [self range];
    NSMutableArray *tiles = [NSMutableArray array];
    
    for (LWFPointObject *point in range) {
        LWFTile *possibleTile;
        
        NSInteger x = tile.x + point.x;
        NSInteger y = tile.y + point.y;
        
        if ([_gameController.tileMap isInBoundsTheTileWithX:x andY:y]) {
            possibleTile = [_gameController.tileMap tileForVertical:y andHorizontal:x];
            
            if ([possibleTile isWalkable]) {
                [tiles addObject:possibleTile];
            }
        }
    }
    
    return tiles;
}

- (NSArray *)creaturesInRangeOfTile:(LWFTile *)tile {
    NSMutableArray *creatures = [NSMutableArray array];
    
    NSArray *tiles = [self tilesInRangeForTile:tile];
    
    for (LWFTile *tile in tiles) {
        LWFCreature *creature = tile.creatureOnTile;
        if (creature != nil) {
            [creatures addObject:creature];
        }
    }
    
    return creatures;
}

- (BOOL)isCreature:(LWFCreature *)creature inRangeOfTile:(LWFTile *)tile {
    NSArray *creatures = [self creaturesInRangeOfTile:tile];
    
    for (LWFCreature *creatureInTile in creatures) {
        if (creature == creatureInTile) {
            if ([self isThereSightToTile:creature.currentTile fromTile:tile]) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    
    return NO;
}

- (BOOL)isThereSightToTile:(LWFTile *)tile fromTile:(LWFTile *)fromTile {
    if (self.fovRadius == 1) {
        return YES;
    }
    LWFVisibilityShadowCasting *visibilityShadowCasting = [[LWFVisibilityShadowCasting alloc]init];
    
    [visibilityShadowCasting doFovStartX:fromTile.x startY:fromTile.y radius:self.fovRadius];
    return [visibilityShadowCasting isTileInSight:tile];
    
}

- (NSArray *)creaturesInAffectedRangeFromTile:(LWFTile *)tile {
    NSMutableArray *creatures = [NSMutableArray array];
    
    NSArray *tiles = [self tilesInAffectedRangeForTile:tile];
    
    for (LWFTile *tile in tiles) {
        LWFCreature *creature = tile.creatureOnTile;
        if (creature != nil) {
            [creatures addObject:creature];
        }
    }
    
    return creatures;
}

- (NSMutableArray *)tilesInAffectedRangeForTile:(LWFTile *)tile {
    NSMutableArray *range = [self affectedRange];
    NSMutableArray *tiles = [NSMutableArray array];
    
    for (LWFPointObject *point in range) {
        LWFTile *possibleTile;
        
        NSInteger x = tile.x + point.x;
        NSInteger y = tile.y + point.y;
        
        if ([_gameController.tileMap isInBoundsTheTileWithX:x andY:y]) {
            possibleTile = [_gameController.tileMap tileForVertical:y andHorizontal:x];
            
            if (possibleTile.cellType != CaveCellTypeWall) {
                [tiles addObject:possibleTile];
            }
        }
    }
    
    return tiles;
}

- (NSMutableArray *)range {
    return nil;
}

- (NSMutableArray *)affectedRange {
    return nil;
}

@end
