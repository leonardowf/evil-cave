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
    LWFGameController *gc = [LWFGameController sharedGameController];
    LWFMap *map = gc.map;
    LWFCreatureBuilder *cb = map.creatureBuilder;
    
    LWFRat *rat = [cb buildWithType:LWFCreatureTypeRat];
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    NSArray *oteWithSameKind = [self.oteQueue oteWithSameClass:[LWFRatSummonSickness class]];
    
    if ([oteWithSameKind count] > 0) {
        [self finishTurn];
        return;
    }

    NSArray *tiles = [map.tileMap neighborsForTile:self.currentTile];
    for (LWFTile *tile in tiles) {
        if (tile.creatureOnTile == nil && [tile isPassable]) {
            rat.nextCreature = player.nextCreature;
            player.nextCreature = rat;
            
            rat.currentTile = tile;
            tile.creatureOnTile = rat;
            rat.position = tile.position;
            [map addChild:rat];
            
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
    
    [self finishTurn];
}

- (void)didBuild {
    self.size = CGSizeMake(self.size.width + 10, self.size.height + 10);
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
