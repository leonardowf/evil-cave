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
#import "LWFStats.h"

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
//        [self startStandingAnimation];
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
    
    [self startStandingAnimation];
    
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
    
//    [self removeActionForKey:@"walking_action"];
    
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

- (NSArray *)getAttackingFramesAnimation {
    NSMutableArray *attackingAtlasArray = [NSMutableArray array];
    NSString *attackingAtlasName = [NSString stringWithFormat:@"%@_attacking_%@", self.spriteImageName, self.currentFacingDirection];
    SKTextureAtlas *attackingAtlas = [SKTextureAtlas atlasNamed:attackingAtlasName];
    
    NSUInteger numImages = attackingAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", attackingAtlasName, i];
        SKTexture *texture = [attackingAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [attackingAtlasArray addObject:texture];
    }
    
    return attackingAtlasArray;
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
    if ([self isDead]) {
        [self finishTurn];
        return;
    }
    
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

#pragma - mark LWFAttackable
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
    
    NSInteger moveOffsetX = tile.position.x - self.position.x;
    NSInteger moveOffsetY = tile.position.y - self.position.y;
    
    if (moveOffsetY < 0) {
        moveOffsetY = moveOffsetY + 40;
    } else if (moveOffsetY > 0) {
        moveOffsetY = moveOffsetY - 40;
    }
    
    if (moveOffsetX < 0) {
        self.currentFacingDirection = @"left";
        moveOffsetX = moveOffsetX + 40;
    } else if (moveOffsetX > 0) {
        self.currentFacingDirection = @"right";
        moveOffsetX = moveOffsetX - 40;
    }
    
    [self startStandingAnimation];
    
    [self moveDistanceHorizontal:moveOffsetX andVertical:moveOffsetY inTime:0.1];
    
    [someBlock invoke];
}

- (void)moveDistanceHorizontal:(NSInteger)horizontal andVertical:(NSInteger)vertical inTime:(float)time {
    
    CGVector vector = CGVectorMake(horizontal, vertical);
    
    SKAction *action = [SKAction moveBy:vector duration:time];
    [self runAction:action completion:^{
        CGVector vector = CGVectorMake(-horizontal, -vertical);
        
        SKAction *backAction = [SKAction moveBy:vector duration:time];
        [self runAction:backAction completion:^{

        }];
    }];
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
    
    [self.stats receivesCombatOutput:combatOutput];
    
    [self displayDamageForCombatOutput:combatOutput];
    
    [self runAction: pulseRed completion:someBlock];
    
}

- (void)replaceTile {
    
    LWFTile *tile = self.currentTile;
    
    SKTexture *texture = [SKTexture textureWithImageNamed:@"bloody_rock_tile"];
    texture.filteringMode = SKTextureFilteringNearest;
    
    [tile setTexture:texture];
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

- (BOOL)isAlive {
    return self.stats.currentHP > 0;
}

- (BOOL)isDead {
    return ![self isAlive];
}

#pragma - mark LWFKillable
- (void)willDieWithCompletion:(void(^)(void))someBlock {
    [self replaceTile];
    self.currentTile.creatureOnTile = nil;
    self.currentTile = nil;
    [someBlock invoke];
    
}

- (void)isDyingWithCompletion:(void(^)(void))someBlock {
    NSArray *dyingFramesAnimation = [self getDyingFramesAnimation];
    
    [self removeActionForKey:@"dying_action"];
    
    if (dyingFramesAnimation != nil && dyingFramesAnimation.count > 0) {
        SKAction *animate = [SKAction animateWithTextures:dyingFramesAnimation timePerFrame:0.4f resize:NO restore:NO];
        SKAction *action = [SKAction repeatAction:animate count:1];
        
        [self runAction:action completion:^{
            [self removeFromParent];
            [someBlock invoke];
        }];

    } else {
        SKAction *disappearAction = [SKAction fadeAlphaTo:0 duration:0.3];
        [self runAction:disappearAction];
        [someBlock invoke];
    }
}

- (NSArray *)getDyingFramesAnimation {
    NSMutableArray *dyingAtlasArray = [NSMutableArray array];
    NSString *dyingAtlasName = [NSString stringWithFormat:@"%@_dying_%@", self.spriteImageName, self.currentFacingDirection];
    SKTextureAtlas *dyingAtlas = [SKTextureAtlas atlasNamed:dyingAtlasName];
    
    NSUInteger numImages = dyingAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%d", dyingAtlasName, i];
        SKTexture *texture = [dyingAtlas textureNamed:textureName];
        texture.filteringMode = SKTextureFilteringNearest;
        [dyingAtlasArray addObject:texture];
    }
    
    return dyingAtlasArray;
}

- (void)diedWithCompletion:(void(^)(void))someBlock {

    [someBlock invoke];
}

- (void)statsChanged {
    
}

@end
