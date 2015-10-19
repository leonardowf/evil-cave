//
//  LWFCreature.m
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCreature.h"
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
#import "LWFLifeBar.h"
#import "LWFSoundPlayer.h"

#import "LWFItemPrototype.h"
#import "LWFItemPrototypeFactory.h"
#import "LWFLootChanceFactory.h"
#import "LWFLootChance.h"
#import "LWFOTEQueue.h"

#import "LWFLifeDisplayer.h"
#import "LWFItem.h"
#import "LWFOTE.h"
#import "LWFOTEPoison.h"

#import "LWFNodeCompletionWithKeyCategory.h"
#import "LWFTextDisplayQueue.h"
#import "LWFAtlasSpriteLoader.h"
#import "LWFSkillTree.h"

@interface LWFCreature () {
    LWFHumbleBeeFindPath *_pathFinder;
    NSUInteger _failedMovements;
    id<LWFLifeDisplayer> _lifeBar;
    NSArray *_lootChances;
}
@end

@implementation LWFCreature

#pragma mark - Construction

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.attacks = [NSMutableArray array];
        self.currentFacingDirection = @"right";
    }
    return self;
}

- (void)build {
    SKTexture *texture = [self getTexture];
    [self setTexture:texture];
    [self setSize:CGSizeMake(32, 32)];
    
    _lifeBar = [self getLifeBar];
    [_lifeBar setStats:self.stats];
    
    LWFLootChanceFactory *lootChanceFactory = [LWFLootChanceFactory sharedLootChanceFactory];
    _lootChances = [lootChanceFactory getLootChancesForKey:self.spriteImageName];
    
    if ([_lifeBar isKindOfClass:[LWFLifeBar class]]) {
        ((LWFLifeBar *)_lifeBar).alpha = 0.0;
        [self addChild:(LWFLifeBar *)_lifeBar];
    }
    
    self.textDisplayQueue = [[LWFTextDisplayQueue alloc]initWithMap:self.map andCreature:self];
}

- (void)didBuild {
    
}

- (id<LWFLifeDisplayer>)getLifeBar {
    LWFLifeBar *lifeBar = [[LWFLifeBar alloc]init];
    [lifeBar setPosition:CGPointMake(-16, 30)];
    
    return lifeBar;
}

#pragma mark - Turn Cycle
- (void)processTurn {
    [self turnBegun];
}

- (void)turnBegun {
    if ([self isDead]) {
        [self finishTurn];
        return;
    }
    
    [self.oteQueue process];
    
    if ([self isDead]) {
        [self finishTurn];
        return;
    }
    
    [self processAIBehavior];
}

- (void)processAIBehavior {
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
            
            if (self.tilePath == nil || self.tilePath.count == 0) {
                [self finishTurn];
                return;
            } else {
                [self walkToExistingPath];
            }
            return;
        } else {
            [self finishTurn];
            return;
        }
    } else if (self.tilePath == nil || [self.tilePath count] == 0) {
    }
    
    [self finishTurn];
}

- (void)finishTurn {
    [self.nextCreature processTurn];
}

#pragma mark - Moveable Cycle

- (void)willMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y; {
    LWFTile *nextTile = tile;
    
    NSUInteger distanceFromTiles = [tile distanceToTile:self.currentTile];
    
    if (distanceFromTiles > 1) {
        [self buildPathToTile:tile];
        if (self.tilePath == nil || self.tilePath.count == 0) {
            [self finishTurn];
            return;
        } else {
            nextTile = [self.tilePath lastObject];
        }
        
    }
    
    if (nextTile.x < self.currentTile.x) { // tá movendo pra esquerda
        self.currentFacingDirection = @"left";
    } else if (nextTile.x > self.currentTile.x) { // tá movendo pra direita
        self.currentFacingDirection = @"right";
    }
    
    if (![nextTile isPassable] && nextTile.cellType != CaveCellTypeEnd) {
        if ([self shouldFinishTurnOnFailedMovement]) {
            [self finishTurn];
            return;
        }
        
        [self notifyMovementFailure];
        
    } else {
        [self updateCurrentTile:nextTile];
        [self moveableToTile:nextTile];
    }
    
}

- (void)moveToTile:(LWFTile *)tile completion:(void(^)(void))someBlock {
    CGFloat movementDuration = 0.3;
    
    [self startWalkingAnimation:^{
        [self startStandingAnimation];
    }];
    
    SKAction *moveAction = [SKAction moveTo:tile.position duration:movementDuration];
    
    [self runAction:moveAction withKey:@"move_action" completion:someBlock];
}

- (void)moveableToTile:(LWFTile *)tile {
    [self moveToTile:tile completion:^{
        
    }];
    
    [self didMoveToTile:tile atX:tile.x andY:tile.y];
}

- (void)didMoveToTile:(LWFTile *)tile atX:(NSUInteger)x andY:(NSUInteger)y {
    [tile steppedOnTile:self];
    
    [self.tilePath removeObject:tile];
    
    _failedMovements = 0;
    
    [self finishTurn];
    
}

- (void)notifyMovementFailure {
    NSLog(@"Criatura falhou na hora de mover");
}

- (BOOL)shouldFinishTurnOnFailedMovement {
    return YES;
}

- (void)updateCurrentTile:(LWFTile *)currentTile {
    LWFTile *previousTile = self.currentTile;
    previousTile.creatureOnTile = nil;
    
    self.currentTile = currentTile;
    currentTile.creatureOnTile = self;
}

- (void)light {
    SKAction *action = [SKAction fadeAlphaTo:1.0 duration:0.3];
    [self runAction:action];
    ((LWFLifeBar *)_lifeBar).alpha = 1.0;
}

- (void)dark {
    self.alpha = 0.0;
    ((LWFLifeBar *)_lifeBar).alpha = 0.0;
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
    
    if (walkingFramesAnimation != nil && walkingFramesAnimation.count > 0) {
        [self removeActionForKey:@"standing_action"];
        SKAction *animate = [SKAction animateWithTextures:walkingFramesAnimation timePerFrame:0.06f];
        SKAction *action = [SKAction repeatAction:animate count:1];
        
        [self runAction:action completion:someBlock];
    } else {
        [someBlock invoke];
    }
}

- (NSArray *)getWalkingFramesAnimation {
    NSString *walkingAtlasName = [NSString stringWithFormat:@"%@_walking_%@", self.spriteImageName, self.currentFacingDirection];
    
    return [LWFAtlasSpriteLoader spritesWithAtlasName:walkingAtlasName];
}

- (NSArray *)getAttackingFramesAnimation {
    NSString *attackingAtlasName = [NSString stringWithFormat:@"%@_attacking_%@", self.spriteImageName, self.currentFacingDirection];
    
    return [LWFAtlasSpriteLoader spritesWithAtlasName:attackingAtlasName];
}

- (NSArray *)getStandingFramesAnimation {
    NSString *standingAtlasName = [NSString stringWithFormat:@"%@_standing_%@", self.spriteImageName, self.currentFacingDirection];
    
    return [LWFAtlasSpriteLoader spritesWithAtlasName:standingAtlasName];
}

- (void)walkToExistingPath {
    LWFTile *nextTile = [self.tilePath lastObject];
    [self willMoveToTile:nextTile atX:nextTile.x andY:nextTile.y];
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
    if (tile.cellType == CaveCellTypeEnd) {
        [tile setWalkable:true];
    }
    
    LWFTileMap *tileMap = self.map.tileMap;
    if (_pathFinder == nil) {
        _pathFinder = [[LWFHumbleBeeFindPath alloc]init];
    }
    _pathFinder.tileMap = tileMap;
    
    NSArray *path = [_pathFinder findPath:self.currentTile.x :self.currentTile.y :tile.x :tile.y];
    
    self.tilePath = [NSMutableArray arrayWithArray:path];
    
    if (tile.cellType == CaveCellTypeEnd) {
        [tile setWalkable:false];
    }
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
    
    // antes de atacar verifica se tem uma animação de walking acontecendo
    // se tiver, garante que ela terminou para então executar o resto
    if ([self actionForKey:@"move_action"] != nil) {
        SKAction *wait = [SKAction waitForDuration:0.3];
        [self runAction:wait completion:^{
            [self moveDistanceHorizontal:moveOffsetX andVertical:moveOffsetY inTime:0.1];
            [someBlock invoke];
        }];
        return;
    }

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
    
    [self receveidDamageLog:combatOutput.damage fromCreature:(LWFCreature *)attacker];
    
    [self.tilePath removeAllObjects];
    
    SKAction *pulseRed = [SKAction sequence:@[
                                              [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.3 duration:0.15],
                                              [SKAction waitForDuration:0.1],
                                              [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
    
    if (combatOutput.damage > 0) {
        [self playHitSound];
        
        [self runAction: pulseRed completion:someBlock];
        
        if ([self shouldShakeOnHit]) {
            [self.map shake:3];
        }
    } else {
        SKAction *wait = [SKAction waitForDuration:0.55];
        [self runAction:wait completion:someBlock];
    }
    
    [self.stats receivesCombatOutput:combatOutput];
    
    [self displayDamageForCombatOutput:combatOutput];
}

- (BOOL)shouldShakeOnHit {
    return NO;
}

- (void)playHitSound {
    [LWFSoundPlayer play:LWFSoundTypePlayerHit withSoundEmitter:self];
}

- (NSString *)getSoundName:(LWFSoundType)soundType {
    return nil;
}

- (void)receveidDamageLog:(NSInteger)damage fromCreature:(LWFCreature *)creature {
    [LWFLogger logAttackedCreature:self damage:damage];
}

- (void)replaceTile {
    
    LWFTile *tile = self.currentTile;
    
    if (tile.cellType == CaveCellTypeDoor) {
        return;
    }
    
    [tile diedOnTile:self];
}

- (void)displayDamageForCombatOutput:(LWFCombatOutput *)combatOutput {
    SKLabelNode *label = [combatOutput getLabel];
    
    [self.textDisplayQueue displayLabel:label];
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

    [someBlock invoke];
    
}

- (LWFSkillTree *)getSkillTree {
    return nil;
}


- (void)isDyingWithCompletion:(void(^)(void))someBlock {
    NSArray *dyingFramesAnimation = [self getDyingFramesAnimation];
    
    [self removeActionForKey:@"dying_action"];
    
    if (dyingFramesAnimation != nil && dyingFramesAnimation.count > 0) {
        SKAction *animate = [SKAction animateWithTextures:dyingFramesAnimation timePerFrame:0.3f resize:NO restore:NO];
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
    NSString *dyingAtlasName = [NSString stringWithFormat:@"%@_dying_%@", self.spriteImageName, self.currentFacingDirection];
    return [LWFAtlasSpriteLoader spritesWithAtlasName:dyingAtlasName];
}

- (void)diedWithCompletion:(void(^)(void))someBlock {
    NSArray *loot = [self getLoots];
    
    [self.currentTile addLoot:loot animated:YES];
    
    [someBlock invoke];
}

- (void)statsChanged {
    [_lifeBar draw];
    
    if (![self isAlive]) {
        [self willDieWithCompletion:^{
            [self isDyingWithCompletion:^{
                [self diedWithCompletion:^{
                    
                }];
            }];
        }];
    }
}

# pragma - mark LWFLootable
- (NSArray *)getLootChances {
    return _lootChances;
}

- (NSArray *)getLoots {
    NSArray *lootChances = [self getLootChances];
    NSMutableArray *loot = [NSMutableArray array];
    
    for (LWFLootChance *lootChance in lootChances) {
        NSInteger amountDropped = [lootChance amountDropped];
        LWFItem *drop = [lootChance buildWithQuantity:amountDropped];
        
        if (drop != nil) {
            [loot addObject:drop];
        }
    }
    return loot;
}

# pragma - mark LWFOTEObserver
- (void)notify:(LWFOTE *)ote turnsLeftChangedTo:(NSInteger)newTurnsLeft {

}

- (void)notifyRemovalOf:(LWFOTE *)ote {
    
}

- (void)notifyOTEActivated:(LWFOTE *)ote {
    if ([ote isKindOfClass:[LWFOTEPoison class]]) {
        LWFOTEPoison *poison = (LWFOTEPoison *)ote;
        LWFCombatOutput *combatOutput = [[LWFCombatOutput alloc]init];
        
        combatOutput.combatOutputType = LWFCombatOutputTypePoison;
        combatOutput.damage = poison.damage;
        
        [self displayDamageForCombatOutput:combatOutput];
        [self.stats receivesCombatOutput:combatOutput];
    }
}

@end