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
#import "LWFAttack.h"

@interface LWFCreature () {
    LWFHumbleBeeFindPath *_pathFinder;
    NSUInteger _failedMovements;
    NSArray *_walkFramesArray;

}
@end

@implementation LWFCreature

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.attacks = [NSMutableArray array];
        self.currentFacingDirection = @"right";
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
    SKTexture *texture = [self getTexture];
    [self setTexture:texture];
    [self setSize:CGSizeMake(32, 32)];
    
}

- (SKTexture *)getTexture {
    NSString *textureWithDirection = [NSString stringWithFormat:@"%@_standing_%@", self.spriteImageName, self.currentFacingDirection];
    
    SKTexture *texture = nil;
    
    texture = [SKTexture textureWithImageNamed:textureWithDirection];
    
    if (texture == nil) {
        texture = [SKTexture textureWithImageNamed:self.spriteImageName];
    }
    
    texture.filteringMode = SKTextureFilteringNearest;
    
    return texture;
}

- (void)startAnimating {
    _walkFramesArray = [self getWalkFrames];
    
    if (_walkFramesArray != nil && _walkFramesArray.count > 0) {
        SKAction *animate = [SKAction animateWithTextures:_walkFramesArray timePerFrame:0.3f];
        SKAction *action = [SKAction repeatActionForever:animate];
        
        [self runAction:action];
    }
}

- (NSArray *)getWalkFrames {
    return nil;
}

- (void)processTurn {
    LWFAttack *melee = [self.attacks firstObject];
    
    if ([melee isCreature:_player inRangeOfTile:self.currentTile]) {
        NSLog(@"player tá no range bro");
    }
    
    if ([self shouldFollowPlayer]) {
        if ([self isAdjacentToPlayer]) {
            // por ataque melee
            [self attackPlayerWithMelee];

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
    [self finishTurn];
    
}

@end
