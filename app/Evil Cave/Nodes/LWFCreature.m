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
#import "LWFMelee.h"
#import "LWFEquips.h"
#import "LWFCombatOutput.h"

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
        self.currentFacingDirection = @"right";
    }
    return self;
}

- (void)requestMoveToTileAtX:(NSUInteger)x andY:(NSUInteger)y {
    [self.movementManager moveable:self requestMoveToTileAtX:x andY:y];
}

- (void)willMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y; {
    if (x < self.currentTile.x) { // tá movendo pra esquerda
        self.currentFacingDirection = @"left";
    } else if (x > self.currentTile.x) { // tá movendo pra direita
        self.currentFacingDirection = @"right";
    }
    
    [self startWalkingAnimation:^{
        [self startStandingAnimation];
    }];

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

- (void)startStandingAnimation {
    NSArray *standingFramesAnimation = [self getStandingFramesAnimation];
    
    [self removeActionForKey:@"standing_action"];
    
    if (standingFramesAnimation != nil && standingFramesAnimation.count > 0) {
        SKAction *animate = [SKAction animateWithTextures:standingFramesAnimation timePerFrame:0.3f];
        SKAction *action = [SKAction repeatActionForever:animate];
        
        [self runAction:action withKey:@"standing_action"];
    }
}

- (void)startWalkingAnimation:(void(^)(void))someBlock {
    NSArray *walkingFramesAnimation = [self getWalkingFramesAnimation];
    
    [self removeActionForKey:@"walking_action"];
    
    if (walkingFramesAnimation != nil && walkingFramesAnimation.count > 0) {
        SKAction *animate = [SKAction animateWithTextures:walkingFramesAnimation timePerFrame:0.05f];
        SKAction *action = [SKAction repeatAction:animate count:2];
        
        [self runAction:action completion:someBlock];
    } else {
        [someBlock invoke];
    }
}

- (NSArray *)getWalkingFramesAnimation {
    NSMutableArray *walkingAtlasArray = [NSMutableArray array];
    NSString *walkingAtlasName = [NSString stringWithFormat:@"%@_walking_%@", self.spriteImageName, self.currentFacingDirection];
    SKTextureAtlas *walkingAtlas = [SKTextureAtlas atlasNamed:walkingAtlasName];
    
    NSUInteger numImages = walkingAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", walkingAtlasName, i];
        SKTexture *texture = [walkingAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [walkingAtlasArray addObject:texture];
    }
    
    return walkingAtlasArray;
}

- (NSArray *)getStandingFramesAnimation {
    NSMutableArray *standingAtlasArray = [NSMutableArray array];
    
    NSString *standingAtlasName = [NSString stringWithFormat:@"%@_standing_%@", self.spriteImageName, self.currentFacingDirection];
    
    SKTextureAtlas *standingAtlas = [SKTextureAtlas atlasNamed:standingAtlasName];
    
    NSUInteger numImages = standingAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", standingAtlasName, i];
        SKTexture *texture = [standingAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [standingAtlasArray addObject:texture];
    }
    return standingAtlasArray;
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

- (LWFMelee *)getMelee {
    for (LWFAttack *attack in self.attacks) {
        if ([attack isKindOfClass:[LWFMelee class]]) {
            return (LWFMelee *)attack;
        }
    }
             
    return nil;
}

/// A criatura passada como parâmetro está no meu range de melee?
- (BOOL)isInTheMeleeRangeTheCreature:(LWFCreature *)creature {
    LWFMelee *melee = [self getMelee];
    
    if (melee == nil) { return NO; }
    
    return [melee isCreature:creature inRangeOfTile:self.currentTile];
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
            withAttack:(LWFAttack *)attack completion:(void(^)(void))someBlock {
    [someBlock invoke];
}

- (void)didAttackTile:(LWFTile *)tile
           withAttack:(LWFAttack *)attack {
    [self finishTurn];
    
}

- (void)willBeAttackedByAttackable:(id<LWFAttackable>)attacker
                        withAttack:(LWFAttack *)attack completion:(void(^)(void))someBlock {
    [someBlock invoke];
}

- (void)attacksAttackable:(id<LWFAttackable>)target
               withAttack:(LWFAttack *)attack
               completion:(void(^)(void))someBlock {
    [someBlock invoke];
    
}

- (void)isBeingAttackedBy:(id<LWFAttackable>)attacker
               withAttack:(LWFAttack *)attack
          forCombatOutput:(LWFCombatOutput *)combatOutput
               completion:(void(^)(void))someBlock {
    
    
    SKAction *pulseRed = [SKAction sequence:@[
                                              [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.3 duration:0.15],
                                              [SKAction waitForDuration:0.1],
                                              [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
    
    [self displayDamageForCombatOutput:combatOutput];
    
    [self runAction: pulseRed completion:someBlock];
    
}

- (void)displayDamageForCombatOutput:(LWFCombatOutput *)combatOutput {
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Munro"];
    [label setFontColor:[UIColor whiteColor]];
    
    label.text = [combatOutput getDamageString];
    label.fontSize = 20;
    label.position = self.currentTile.position;
    
    [self.map addChild:label];
    
    SKAction *action = [SKAction moveByX:0 y:70 duration:1.2];
    [label runAction:action completion:^{
        SKAction *action = [SKAction fadeAlphaTo:0 duration:0.2];
        [label runAction:action completion:^{
            
            
        }];
        
    }];
}

- (LWFStats *)getStats {
    return self.stats;
}

- (LWFEquips *)getEquips {
    return self.equips;
}

@end
