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

@interface LWFCreature () {
    LWFHumbleBeeFindPath *_pathFinder;
    NSUInteger _failedMovements;

}
@end

@implementation LWFCreature

- (void)requestMoveToTileAtX:(NSUInteger)x andY:(NSUInteger)y {
    [self.movementManager moveable:self requestMoveToTileAtX:x andY:y];
}

- (void)willMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y; {
    
}

- (void)failedToMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    _failedMovements++;
    
    if (_failedMovements > 3) {
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
    if (self.tilePath == nil || [self.tilePath count] == 0) {
        [self buildPathToSomeDestiny];
    }
    
    LWFTile *nextTile = [self.tilePath lastObject];
    [self requestMoveToTileAtX:nextTile.x andY:nextTile.y];
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
    
    self.tilePath = [NSMutableArray arrayWithArray:path];}


@end
