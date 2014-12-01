//
//  LWFCreature.m
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCreature.h"
#import "LWFMovementManager.h"
#import "LWFTurnList.h"
#import "LWFMap.h"
#import "LWFTileMap.h"
#import "LWFHumbleBeeFindPath.h"
#import "LWFPlayer.h"
#import "LWFTileMap.h"
#import "LWFAttackManager.h"

@interface LWFCreature () {
    LWFHumbleBeeFindPath *_pathFinder;
    NSUInteger _failedMovements;

}
@end

@implementation LWFCreature

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.attacks = [NSMutableArray array];
    }
    return self;
}

- (void)requestMoveToTileAtX:(NSUInteger)x andY:(NSUInteger)y {
    [self.movementManager moveable:self requestMoveToTileAtX:x andY:y];
}

- (void)willMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y; {
    
}

- (void)failedToMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    _failedMovements++;
    
    if (_failedMovements > MAX_NUMBER_PATH_FIND_TRIES) {
        _failedMovements = 0;
        [self.turnList creatureFinishedTurn:self];
    } else {
        LWFTile *destinyTile = [self.tilePath firstObject];
        [self.tilePath removeAllObjects];
        [self buildPathToTile:destinyTile];
        
        LWFTile *nextTile = [self.tilePath lastObject];
        [self requestMoveToTileAtX:nextTile.x andY:nextTile.y];
    }
}
- (void)didMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    [self.tilePath removeObject:tile];
    [self.turnList creatureFinishedTurn:self];
    _failedMovements = 0;
    
}

- (void)updateCurrentTile:(LWFTile *)currentTile {
    LWFTile *previousTile = self.currentTile;
    previousTile.creatureOnTile = nil;
    
    self.currentTile = currentTile;
    currentTile.creatureOnTile = self;
}

- (void)moveToTile:(LWFTile *)tile {
    SKAction *moveAction = [SKAction moveTo:tile.position duration:0.2];
    [self runAction: moveAction];
}

- (void)build {
    [self setTexture:[SKTexture textureWithImage:[UIImage imageNamed:self.spriteImageName]]];
    [self setSize:CGSizeMake(32, 32)];
}

- (void)processTurn {
    if ([self shouldFollowPlayer]) {
        if ([self isAdjacentToPlayer]) {
            // por ataque melee
            [self attackPlayerWithMelee];
            [self finishTurn];
            return;
        } else {
            if ([self.player isSurrounded]) {
                [self finishTurn];
                return;
            }
        }
        
        LWFTile *closestTile = [self closestNeighborToPlayer];
        if (closestTile != nil) {
            [self buildPathToTile:closestTile];
        } else {
            [self finishTurn];
        }
    } else if (self.tilePath == nil || [self.tilePath count] == 0) {
        [self buildPathToSomeDestiny];
    }
    
    [self walkToExistingPath];
    

}

- (void)walkToExistingPath {
    LWFTile *nextTile = [self.tilePath lastObject];
    [self requestMoveToTileAtX:nextTile.x andY:nextTile.y];
}

- (BOOL)isAdjacentToPlayer {
    NSArray *adjacentsToPlayer = [self.map.tileMap neighborsForTile:self.player.currentTile];
    
    for (LWFTile *tile in adjacentsToPlayer) {
        if (tile.x == self.currentTile.x && tile.y == self.currentTile.y) {
            return YES;
        }
    }
    
    return NO;
}

- (LWFTile *)closestNeighborToPlayer {
    LWFTile *originTile = self.currentTile;
    LWFTile *destinyTile = _player.currentTile;
    
    LWFTile *closest = [self.map.tileMap closestNeighborFromTile:originTile toTile:destinyTile];
    
    return closest;
}

- (BOOL)shouldFollowPlayer {
    NSUInteger distanceToPlayer = [self.currentTile distanceToTile:self.player.currentTile];
    if (distanceToPlayer < 5) {
        return YES;
    }
    return NO;
}

- (void)buildPathToSomeDestiny {
    LWFTileMap *tileMap = self.map.tileMap;
    LWFTile *destinyTile = [tileMap randomEmptyWalkableTile];
    [self buildPathToTile:destinyTile];
}

- (void)buildPathToTile:(LWFTile *)tile {
    LWFTileMap *tileMap = self.map.tileMap;
    if (_pathFinder == nil) {
        _pathFinder = [[LWFHumbleBeeFindPath alloc]init];
        _pathFinder.tileMap = tileMap;
    }
    
    NSArray *path = [_pathFinder findPath:self.currentTile.x :self.currentTile.y :tile.x :tile.y];
    
    self.tilePath = [NSMutableArray arrayWithArray:path];
}

- (void)finishTurn {
    [self.turnList creatureFinishedTurn:self];
}

- (BOOL)isSurrounded {
    NSArray *neighbors = [self.map.tileMap neighborsForTile:self.currentTile];
    
    for (LWFTile* tile in neighbors) {
        if ([tile isPassable]) {
            return NO;
        }
    }
    
    return YES;
}
#pragma - mark attacks
- (void)attackPlayerWithMelee {
    LWFAttack *attack = [self.attacks firstObject];
    [self requestAttackToTile:self.player.currentTile withAttack:attack];
}

#pragma - mark ATTACKABLE
- (void)requestAttackToTile:(LWFTile *)tile
                 withAttack:(LWFAttack *)attack {
    
    [self.attackManager attackable:self requestedAttackToTile:tile withAttack:attack];
    
}

- (void)failedToAttackTile:(LWFTile *)tile
                withAttack:(LWFAttack *)attack
                   because:(FailedAttackReason)reason {
    
}

- (void)willAttackTile:(LWFTile *)tile
            withAttack:(LWFAttack *)attack {
    
}

- (void)didAttackTile:(LWFTile *)tile
           withAttack:(LWFAttack *)attack {
    
}

@end
