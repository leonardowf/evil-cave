//
//  LWFRatKing.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 9/14/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFRatKing.h"
#import "LWFGameController.h"
#import "LWFMap.h"
#import "LWFCreatureBuilder.h"
#import "LWFRat.h"
#import "LWFPlayer.h"
#import "LWFTileMap.h"
#import "LWFRatSummonSickness.h"
#import "LWFOTEQueue.h"

@interface LWFRatKing () {
    LWFGameController *_gameController;
    LWFMap *_map;
    LWFCreatureBuilder *_creatureBuilder;
    LWFPlayer *_player;

}
@end

@implementation LWFRatKing

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spriteImageName = @"rat_king";
        self.name = @"Rat King";
    }
    return self;
}

- (void)build {
    [super build];
}

- (void)processAIBehavior {
    if ([self canSummon]) {
        [self summonRat];
        [self finishTurn];
    } else {
        [self runAwayIfCan];
    }
}

- (BOOL)canSummon {
    NSArray *oteWithSameKind = [self.oteQueue oteWithSameClass:[LWFRatSummonSickness class]];
    
    if ([oteWithSameKind count] > 0) {
        return false;
    }
    
    return true;
}

- (void)runAwayIfCan {
    NSArray *tiles = [_map.tileMap neighborsForTile:self.currentTile];
    NSInteger highestDistance = 0;
    LWFTile *highestDistanceTile = nil;
    
    for (LWFTile *tile in tiles) {
        NSInteger distance = [tile distanceToTile:_player.currentTile];
        
        if (![tile isPassable]) {
            continue;
        }
        
        if (distance > highestDistance) {
            highestDistance = distance;
            highestDistanceTile = tile;
        }
        
        if (distance == highestDistance && tile.cellType == CaveCellTypeDoor) {
            highestDistance = distance;
            highestDistanceTile = tile;
        }
    }
    
    if (highestDistanceTile != nil) {
         [self willMoveToTile:highestDistanceTile atX:highestDistanceTile.x andY:highestDistanceTile.y];
    } else {
        [super processAIBehavior];
    }
    
}

- (void)summonRat {
    LWFRat *rat = (LWFRat *)[_creatureBuilder buildWithType:LWFCreatureTypeRat];
    
    NSArray *tiles = [_map.tileMap neighborsForTile:self.currentTile];
    for (LWFTile *tile in tiles) {
        if (tile.creatureOnTile == nil && [tile isPassable]) {
            rat.nextCreature = _player.nextCreature;
            _player.nextCreature = rat;
            
            rat.currentTile = tile;
            tile.creatureOnTile = rat;
            rat.position = tile.position;
            [_map addChild:rat];
            
            if (tile.isLit) {
                [rat light];
            } else {
                [rat dark];
            }
            
            LWFRatSummonSickness *summonSickness = [LWFRatSummonSickness new];
            [self.oteQueue addOTE:summonSickness];
            
            break;
        }
    }
}

- (void)didBuild {
    self.size = CGSizeMake(self.size.width + 10, self.size.height + 10);
    
    _gameController = [LWFGameController sharedGameController];
    _map = _gameController.map;
    _creatureBuilder = _map.creatureBuilder;
    
    _player = [LWFPlayer sharedPlayer];
}

- (NSArray *)getDyingFramesAnimation {
    return nil;
}

- (NSArray *)getWalkingFramesAnimation {
    return nil;
}

- (NSArray *)getAttackingFramesAnimation {
    return nil;
}

@end
