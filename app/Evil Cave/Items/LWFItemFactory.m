//
//  LWFItemFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//
#import "LWFItemFactory.h"
#import "LWFNewItem.h"
#import "LWFItemPrototype.h"
#import "LWFEquipment.h"
#import "LWFRandomUtils.h"
#import "LWFGold.h"

@implementation LWFItemFactory

- (LWFNewItem *)manufactureWithItemPrototype:(LWFItemPrototype *)itemPrototype {
    LWFNewItem *item = nil;
    
    if ([self itemPrototypeIsEquipment:itemPrototype]) {
        item = [self manufactureEquipment:itemPrototype];
    } else if ([self itemPrototypeIsGold:itemPrototype]) {
        item = [self manufactureGold:itemPrototype];
    }
    
    item.size = CGSizeMake(TILE_SIZE, TILE_SIZE);
    
    [self addAnimations:itemPrototype forItem:item];
    
    return item;
}

- (BOOL)itemPrototypeIsEquipment:(LWFItemPrototype *)itemPrototype {
    NSArray *equipmentCategories = [self getEquipmentCategories];
    
    if ([equipmentCategories containsObject:itemPrototype.category]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)itemPrototypeIsGold:(LWFItemPrototype *)itemPrototype {
    if ([itemPrototype.category isEqualToString:@"money"]) {
        return YES;
    }
    
    return NO;
}

- (LWFEquipment *)manufactureEquipment:(LWFItemPrototype *)prototype {
    LWFEquipment *equipment = nil;
    
    NSString *textureName = [NSString stringWithFormat:@"item_%@", prototype.imageName];
    SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
    texture.filteringMode = SKTextureFilteringNearest;
    
    equipment = [[LWFEquipment alloc]initWithTexture:texture];

    [equipment calculateForKey:@"lowdamage" andPrototype:prototype];
    [equipment calculateForKey:@"highdamage" andPrototype:prototype];
    [equipment calculateForKey:@"strength" andPrototype:prototype];
    [equipment calculateForKey:@"HP" andPrototype:prototype];
    [equipment calculateForKey:@"armor" andPrototype:prototype];

    equipment.quantity = 1;

    equipment.prototype = prototype;

    equipment.name = prototype.name;
    equipment.category = prototype.category;
    equipment.identifier = prototype.identifier;
    equipment.imageName = prototype.imageName;
    
    return equipment;
}

- (LWFGold *)manufactureGold:(LWFItemPrototype *)prototype {
    NSString *textureName = [NSString stringWithFormat:@"item_%@", prototype.imageName];
    SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
    texture.filteringMode = SKTextureFilteringNearest;
    
    LWFGold *gold = [[LWFGold alloc]initWithTexture:texture];
    
    gold.quantity = 1;
    
    return gold;
}

- (void)addAnimations:(LWFItemPrototype *)prototype forItem:(LWFNewItem *)item {
    SKTextureAtlas *atlas = nil;
        NSString *textureName = [NSString stringWithFormat:@"item_%@", prototype.imageName];
    
    if ([prototype.atlas boolValue]) {
        atlas = [SKTextureAtlas atlasNamed:textureName];
        if (atlas != nil) {
            NSMutableArray *atlasTextures = [NSMutableArray array];
            NSUInteger numImages = atlas.textureNames.count;
            for (int i=1; i <= numImages; i++) {
                NSString *textureNameFromAtlas = [NSString stringWithFormat:@"%@_%d", textureName, i];
                SKTexture *texture = [atlas textureNamed:textureNameFromAtlas];
                texture.filteringMode = SKTextureFilteringNearest;
                [atlasTextures addObject:texture];
            }
            
            SKAction *animate = [SKAction animateWithTextures:atlasTextures timePerFrame:0.3f];
            SKAction *action = [SKAction repeatActionForever:animate];
            [item runAction:action withKey:@"item_action"];
        }
    }
}

- (NSArray *)getEquipmentCategories {
    return @[@"weapon", @"armor", @"boots", @"accessory"];
}

@end
