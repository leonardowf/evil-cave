//
//  LWFMap.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFMap.h"

#import "LWFMapDimension.h"
#import "LWFTileMap.h"
#import "LWFTile.h"
#import "LWFPlayer.h"
#import "LWFHumbleBeeFindPath.h"
#import "LWFTurnList.h"
#import "LWFCreatureBuilder.h"
#import "LWFPlayer.h"
#import "LWFAttackManager.h"
#import "LWFPointObject.h"
#import "LWFInventory.h"

#import "LWFDifficultyManager.h"
#import "LWFFloorDifficulty.h"
#import "LWFChest.h"

@interface LWFMap () {
    LWFTurnList *_turnList;
    LWFCreatureBuilder *_creatureBuilder;
    
    BOOL _blockUserInteraction;
    LWFPointObject *_touchQueue;
    
    CGSize _size;
    NSInteger _floor;
    LWFFloorDifficulty *_floorDifficulty;

}

@end

@implementation LWFMap

- (instancetype)initWithScreenSize:(CGSize)size andFloor:(NSInteger)floor
{
    self = [super init];
    if (self) {
        _size = size;
        _floor = floor;
//        self.player = [LWFPlayer sharedPlayer];
        
    }
    return self;
}

- (void)build {

    LWFDifficultyManager *difficultyManager = [[LWFDifficultyManager alloc]init];
    _floorDifficulty = [difficultyManager getFloorDifficultyForFloor:_floor];
    
    _mapDimension = [[LWFMapDimension alloc]initWithGridSize:_size numberTilesVertical:_floorDifficulty.numberTilesVertical numberTilesHorizontal:_floorDifficulty.numberTilesHorizontal andTileSize:TILE_SIZE];
    
    _tileMap = [[LWFTileMap alloc]initWithMapDimension:_mapDimension];
    _turnList = [[LWFTurnList alloc]init];
    
    _attackManager = [[LWFAttackManager alloc]initWithTileMap:_tileMap];
    
    _creatureBuilder = [[LWFCreatureBuilder alloc]initWithMap:self movementManager:_movementManager andMapDimension:_mapDimension andTurnList:_turnList andAttackManager:_attackManager];
    
}

- (void)addTiles {
    for (NSInteger x = 0; x < self.mapDimension.numberTilesHorizontal; x++) {
        for (NSInteger y = 0; y < self.mapDimension.numberTilesVertical; y++) {
            LWFTile *tile = [self.tileMap tileForVertical:y andHorizontal:x];
            
            [self addChild:(SKSpriteNode *)tile];
        }
    }
}

- (LWFTile *)tileForPoint:(CGPoint)point {
    CGPoint tileCoordinate = [self tileCoordinateForTouchPoint:point];
    
    NSInteger x = tileCoordinate.x;
    NSInteger y = tileCoordinate.y;
    
    if (x < 0 || y < 0 || x >= self.mapDimension.numberTilesHorizontal || y >= self.mapDimension.numberTilesVertical) {
        return nil;
    }
    
    LWFTile *tile = [self.tileMap tileForVertical:y andHorizontal:x];
    
    return tile;
}

- (CGPoint)tileCoordinateForTouchPoint:(CGPoint)touchPoint {
    CGFloat x = touchPoint.x / self.mapDimension.tileSize.width;
    CGFloat y = touchPoint.y / self.mapDimension.tileSize.height;
    
    NSInteger xi = (x + 0.5);
    NSInteger yi = (y + 0.5);
    
    return CGPointMake(xi, yi);
}

- (void)addPlayer:(LWFPlayer *)player {
    [player removeFromParent];
    
    self.player = player;
    self.player.position = self.tileMap.startTile.position;
    [self.player setCurrentTile:self.tileMap.startTile];
    self.player.currentTile.creatureOnTile = player;
    self.player.map = self;

    
    [_turnList.creatures addObject:player];
    player.turnList = _turnList;
    _turnList.map = self;
    _player.movementManager = _movementManager;
    
    [self addChild:self.player];
}

- (void)newTurnCycleStarted {
    if (_touchQueue != nil) {
        [_player cancelPreExistingActions];
    }
}

- (void)processTouchQueue {
    CGPoint point = [_touchQueue toPoint];
    _touchQueue = nil;
    [self playerInteractionWithPoint:point];
}

- (void)unlockUserInteraction  {
    _blockUserInteraction = NO;
}

- (void)userTouchedPoint:(CGPoint)point {
    LWFInventory *inventory = [LWFInventory sharedInventory];
    if ([inventory isOpen]) {
        return;
    }
    
    if (_blockUserInteraction) {
        _touchQueue = [LWFPointObject pointWithX:point.x andY:point.y];
        return;
    }
    
    if ([_player isDead]) {
        return;
    }
    
    [self playerInteractionWithPoint:point];
}

- (void)playerInteractionWithPoint:(CGPoint)point {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    if ([player isDead]) {
        return;
    }
    
    LWFTile *tile = [self tileForPoint:point];
    
    if ([tile.chest canInteract]) {
        [tile.chest interact];
        return;
    }
    
    if (self.currentItemRange != nil) {
        if ([self.currentItemRange tileIsOnRange:tile]) {
            NSLog(@"tá no range");
            [self.currentItemRange throwItemAtTile:tile];
        } else {
            NSLog(@"Não tá no range");
            [self.currentItemRange removeRangeOverlay];
        }
        self.currentItemRange = nil;
        return;
    }
    
    LWFCreature *creatureOnTile = tile.creatureOnTile;
    
    if (creatureOnTile != nil && creatureOnTile != self.player) {
        
        if ([self.player isInTheMeleeRangeTheCreature:creatureOnTile]) {
            _blockUserInteraction = YES;
            [self.player requestAttackToTile:tile withAttack:(LWFAttack *)[self.player getMelee]];
        } else {
            [self.player lockTarget:creatureOnTile];
        }
        return;
    }
    
    if (tile != nil) {
        if (tile != self.player.currentTile && [tile isPassable]) {
            _blockUserInteraction = YES;
            [_player willMoveToTile:tile atX:tile.x andY:tile.y];
        } else if (tile == self.player.currentTile) {
            [self.player cancelPreExistingActions];
            [self.player requestTakeItem];
        } else if (tile.cellType == CaveCellTypeEnd) {
            [_player willMoveToTile:tile atX:tile.x andY:tile.y];
        }
    }
}

- (void)checkItemRangeInteractionForTile:(LWFTile *)tile {
    
}

- (void)movementRequestIsInvalid {
    _blockUserInteraction = NO;
}

- (void)resetTouchQueue {
    _touchQueue = nil;
}

- (void)blockUserInteraction {
    _blockUserInteraction = YES;
}

- (void)unblockUserInteraction {
    _blockUserInteraction = NO;
}

- (void)loadGame {
    [self createPlayer];
    [self createCreatures];
    [self chooseCreaturePositions];
    [self chooseChestsPositions];
    [_player doFov];
}

- (void)createPlayer {       
    LWFPlayer *player = (LWFPlayer *)[_creatureBuilder buildWithType:LWFCreatureTypeWarrior];
    [self addPlayer:player];
    [player statsChanged];
    [player startStandingAnimation];
}

- (void)chooseChestsPositions {
    for (LWFChest *chest in _floorDifficulty.chests) {
        LWFTile *tile = [_tileMap randomEmptyWalkableTileNotInStartAndEndWithWalkableAdjacents:4];
        tile.chest = chest;
        tile.chest.alpha = 0.0;
        tile.chest.tile = tile;
        [chest setPosition:CGPointMake(tile.position.x, tile.position.y)];
        [self addChild:chest];
        [chest startAnimation:LWFChestAnimationTypeClosed completion:nil];
    }
}

- (void)createCreatures {
    [_floorDifficulty buildCreaturesWithBuilder:_creatureBuilder];

    _player.nextCreature = _floorDifficulty.creatures[0];
    [_turnList.creatures addObjectsFromArray:_floorDifficulty.creatures];
    
    NSInteger currentIndex = 0;
    
    for (LWFCreature *creature in _floorDifficulty.creatures) {
        if ([_floorDifficulty.creatures lastObject] == creature) {
            break;
        }
        
        NSInteger nextIndex = currentIndex + 1;
        LWFCreature *nextCreature = _floorDifficulty.creatures[nextIndex];
        creature.nextCreature = nextCreature;
        
        currentIndex++;
    }
    
    LWFCreature *last = _floorDifficulty.creatures.lastObject;
    last.nextCreature = _player;
    
}

- (void)chooseCreaturePositions {
    for (LWFCreature *creature in _turnList.creatures) {
        if (creature != _player) {
            LWFTile *tile = [_tileMap randomEmptyWalkableTileNotInStartAndEnd];
            tile.creatureOnTile = creature;
            creature.position = tile.position;
            creature.currentTile = tile;
            
            [self addChild:creature];
            [creature startStandingAnimation];
        }
    }
}

- (void)moveCameraToTile:(LWFTile *)tile {
    SKScene *scene = [self scene];
    float xScale = self.xScale;
    
    CGPoint calculatedPosition = CGPointMake((-(xScale*tile.position.x-(scene.size.width/2))), (-(xScale*tile.position.y-(scene.size.height/2))));
    CGPoint newCameraPosition = calculatedPosition;
    
    SKAction *moveCameraAction = [SKAction moveTo:newCameraPosition duration:0.3];
    [self runAction:moveCameraAction];
}


// TODO: REPETIDO!!!
- (void)moveCameraToTile:(LWFTile *)tile completion:(void(^)(void))someBlock {
    SKScene *scene = [self scene];
    float xScale = self.xScale;
    
    CGPoint calculatedPosition = CGPointMake((-(xScale*tile.position.x-(scene.size.width/2))), (-(xScale*tile.position.y-(scene.size.height/2))));
    CGPoint newCameraPosition = calculatedPosition;
    
    SKAction *moveCameraAction = [SKAction moveTo:newCameraPosition duration:0.3];
    [self runAction:moveCameraAction completion:someBlock];
}


- (void)printPoint:(CGPoint)point withPrefix:(NSString *)prefix {
    NSLog(@"\n%@ --- x: %0.f y: %0.f", prefix, point.x, point.y);
}

@end
