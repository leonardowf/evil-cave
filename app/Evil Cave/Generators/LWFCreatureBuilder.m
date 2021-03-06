//
//  LWFCreatureBuilder.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/23/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCreatureBuilder.h"
#import "LWFCreature.h"

#import "LWFPlayer.h"
#import "LWFRat.h"
#import "LWFRadioactiveRat.h"
#import "LWFPoopThrowerRat.h"
#import "LWFRatKing.h"

#import "LWFMapDimension.h"
#import "LWFTurnList.h"
#import "LWFMap.h"
#import "LWFAttacksBuilder.h"

#import "LWFMelee.h"
#import "LWFGameController.h"

#import "LWFStats.h"
#import "LWFOTEQueue.h"

@interface LWFCreatureBuilder () {
    LWFMovementManager *_movementManager;
    LWFMap *_map;
    LWFMapDimension *_mapDimension;
    LWFTurnList *_turnList;
    LWFAttackManager *_attackManager;
    LWFAttacksBuilder *_attacksBuilder;
    NSDictionary *_creatureStats;
}
@end
@implementation LWFCreatureBuilder

- (instancetype)initWithMap:(LWFMap *)map movementManager:(LWFMovementManager *)movementManager andMapDimension:(LWFMapDimension *)mapDimension andTurnList:(LWFTurnList *)turnList andAttackManager:(LWFAttackManager *)attackManager
{
    self = [super init];
    if (self) {
        LWFGameController *gameController = [LWFGameController sharedGameController];
        
        _movementManager = movementManager;
        _map = map;
        _mapDimension = mapDimension;
        _turnList = turnList;
        _attackManager = attackManager;
        _attacksBuilder = [[LWFAttacksBuilder alloc]init];
        
        gameController.tileMap = map.tileMap;
        
        _creatureStats = [self getStatsDictionary];

    }
    return self;
}

- (NSDictionary *)getStatsDictionary {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"creature_stats"
                                                         ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSData *jsonData = [myJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDataDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:kNilOptions error:&error];
    
    return jsonDataDict;
}

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType {
    LWFCreature *creature;
    
    if (creatureType == LWFCreatureTypePoopThrowerRat) {
        creature = [[LWFPoopThrowerRat alloc]init];
    } else if (creatureType == LWFCreatureTypeRat) {
        creature = [[LWFRat alloc]init];
    } else if (creatureType == LWFCreatureTypeRadioactiveRat) {
        creature = [[LWFRadioactiveRat alloc]init];
    } else if (creatureType == LWFCreatureTypeWarrior) {
        creature = [LWFPlayer sharedPlayer];
        creature.spriteImageName = @"warrior";
    } else if (creatureType == LWFCreatureTypeRatKing) {
        creature = [[LWFRatKing alloc]init];
    }
    
    if (creature != nil) {
        
        if (creature.stats == nil) {
            NSDictionary *statsDictionary = [self dictionaryStatsForCreatureType:creatureType];
            LWFStats *stats = [self statsForDictionary:statsDictionary andKillable:creature];
            stats.killable = creature;
            
            creature.stats = stats;
        }
        
        creature.map = _map;
        [creature build];
        creature.movementManager = _movementManager;
        creature.attackManager = _attackManager;
        creature.turnList = _turnList;
        creature.size = _mapDimension.tileSize;
        creature.player = _map.player;
        creature.attacks = [_attacksBuilder attacksForCreatureType:creatureType];
        
        // Como o player é um singleton, precisamos manter a OTEQUEUE dele
        if (creature.oteQueue == nil) {
            creature.oteQueue = [[LWFOTEQueue alloc]init];
        }
        
        creature.alpha = 0.0;
        
        [creature didBuild];
    }
    
    return creature;
}

- (LWFCreature *)buildWithType:(LWFCreatureType)creatureType andSize:(CGSize)size {
    LWFCreature *creature = [self buildWithType:creatureType];
    creature.size = size;
    return creature;
}

- (NSDictionary *)dictionaryStatsForCreatureType:(LWFCreatureType)creatureType {
    NSDictionary *creatureStatsDictionary = nil;
    
    if (creatureType == LWFCreatureTypePoopThrowerRat) {
        creatureStatsDictionary = [_creatureStats objectForKey:@"poop_thrower_rat"];
    } else if (creatureType == LWFCreatureTypeWarrior) {
        creatureStatsDictionary = [_creatureStats objectForKey:@"warrior"];
    } else if (creatureType == LWFCreatureTypeRat) {
        creatureStatsDictionary = [_creatureStats objectForKey:@"rat"];
    } else if (creatureType == LWFCreatureTypeRadioactiveRat) {
        creatureStatsDictionary = [_creatureStats objectForKey:@"radioactive_rat"];
    } else if (creatureType == LWFCreatureTypeRatKing) {
        creatureStatsDictionary = [_creatureStats objectForKey:@"rat_king"];
    }
    
    return creatureStatsDictionary;
}

- (LWFStats *)statsForDictionary:(NSDictionary *)dictionary andKillable:(id<LWFKillable>)killable {
    LWFStats *stats = [[LWFStats alloc]initWithDictionary:dictionary andKilladble:killable];
    
    return stats;
}

@end
