//
//  LWFChestFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFChestFactory.h"
#import "LWFChestChance.h"
#import "LWFChest.h"
#import "LWFLootChance.h"

@implementation LWFChestFactory

SINGLETON_FOR_CLASS(ChestFactory)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadFromJson];
    }
    return self;
}

- (void)loadFromJson {
    NSDictionary *jsonChances = [self getDictionaryFromJson];
    
    NSMutableArray *chestChances = [NSMutableArray array];
    
    for (NSDictionary *dict in jsonChances) {
        LWFChestChance *chestChance = [[LWFChestChance alloc]initWithDictionary:dict];
        [chestChances addObject:chestChance];
    }
    self.chestChances = chestChances;
}

- (NSArray *)getChestsForFloor:(NSInteger)floor {
    NSMutableArray *chests = [NSMutableArray array];
    LWFChestChance *chestChance = [self findChestChanceForFloor:floor];
    NSInteger amountRespawned = [chestChance amountRespawned];
    
    for (NSInteger i = 0; i < amountRespawned; i++) {
        LWFChest *chest = [self buildChest];
        [self addItemsToChest:chest fromLootChances:chestChance.lootChances];
        [chests addObject:chest];
    }
    
    return chests;
}

/*
    Sorteia cada umas das lootChances e adiciona na chest se sorteio positivo
 */
- (void)addItemsToChest:(LWFChest *)chest fromLootChances: (NSArray *)lootChances {
    for (LWFLootChance *lootChance in lootChances) {
        NSInteger amount = [lootChance amountDropped];
        LWFItem *item = [lootChance buildWithQuantity:amount];
        
        if (item != nil) {
            [chest.items addObject:item];
        }
    }
}

- (LWFChest *)buildChest {
    SKTexture *texture = [SKTexture textureWithImageNamed:@"closed_chest"];
    [texture setFilteringMode:SKTextureFilteringNearest];
    
    LWFChest *chest = [[LWFChest alloc]initWithTexture:texture];
    chest.size = CGSizeMake(TILE_SIZE, TILE_SIZE);
    chest.items = [NSMutableArray array];
    
    return chest;
}

/**
    Procura uma ChestChance para construir
    se não encontrar, pega a ChestChance mais alta que é menor que a procurada
 */
- (LWFChestChance *)findChestChanceForFloor:(NSInteger)floor {

    LWFChestChance *chestChance = [self.chestChances firstObject];
    return chestChance;
}

- (NSDictionary *)getDictionaryFromJson {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chest_chances"
                                                         ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSData *jsonData = [myJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDataDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:kNilOptions error:&error];
    
    return jsonDataDict;
}

@end
