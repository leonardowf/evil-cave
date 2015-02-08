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

@interface LWFMap () {
    LWFTurnList *_turnList;
    LWFCreatureBuilder *_creatureBuilder;
    
    BOOL _blockUserInteraction;
    LWFPointObject *_touchQueue;

}
@end

@implementation LWFMap

- (instancetype)initWithMapDimension:(LWFMapDimension *)mapDimension
{
    self = [super init];
    if (self) {
        _mapDimension = mapDimension;
        _tileMap = [[LWFTileMap alloc]initWithMapDimension:mapDimension];
        _turnList = [[LWFTurnList alloc]init];

        _attackManager = [[LWFAttackManager alloc]initWithTileMap:_tileMap];
        
        _creatureBuilder = [[LWFCreatureBuilder alloc]initWithMap:self movementManager:_movementManager andMapDimension:_mapDimension andTurnList:_turnList andAttackManager:_attackManager];
        
    }
    return self;
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
    if (_blockUserInteraction) {
        _touchQueue = [LWFPointObject pointWithX:point.x andY:point.y];
        return;
    }
    
    [self playerInteractionWithPoint:point];
}

- (void)playerInteractionWithPoint:(CGPoint)point {
    LWFTile *tile = [self tileForPoint:point];
    
    LWFCreature *creatureOnTile = tile.creatureOnTile;
    
    if (creatureOnTile != nil && creatureOnTile != self.player) {
        
        if ([self.player isInTheMeleeRangeTheCreature:creatureOnTile]) {
            _blockUserInteraction = YES;
            [self.player requestAttackToTile:tile withAttack:(LWFAttack *)[self.player getMelee]];
        } else {
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
        }
    }
}

- (void)movementRequestIsInvalid {
    _blockUserInteraction = NO;
}

- (void)loadGame {
    [self createPlayer];
    [self createCreatures];
    [self chooseCreaturePositions];
}

- (void)createPlayer {
    LWFPlayer *player = (LWFPlayer *)[_creatureBuilder buildWithType:LWFCreatureTypeWarrior];
    [self addPlayer:player];
    [player statsChanged];
    [player startStandingAnimation];
}

- (void)createCreatures {

    LWFCreature *creature1 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature1];
    
    _player.nextCreature = creature1;
    
    LWFCreature *creature2 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature2];
    creature1.nextCreature = creature2;
    
    LWFCreature *creature3 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature3];
    creature2.nextCreature = creature3;
    
    LWFCreature *creature4 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature4];
    creature3.nextCreature = creature4;
    
    LWFCreature *creature5 = [_creatureBuilder buildWithType:LWFCreatureTypeRadioactiveRat];
    [_turnList.creatures addObject:creature5];
    creature4.nextCreature = creature5;
    
    LWFCreature *creature6 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature6];
    creature5.nextCreature = creature6;
    
    LWFCreature *creature7 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature7];
    creature6.nextCreature = creature7;
    
    LWFCreature *creature8 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature8];
    creature7.nextCreature = creature8;
    
    LWFCreature *creature9 = [_creatureBuilder buildWithType:LWFCreatureTypeRat];
    [_turnList.creatures addObject:creature9];
    creature8.nextCreature = creature9;
    
    creature9.nextCreature = _player;
    
}

- (void)chooseCreaturePositions {
    for (LWFCreature *creature in _turnList.creatures) {
        if (creature != _player) {
            LWFTile *tile = [_tileMap randomEmptyWalkableTile];
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
