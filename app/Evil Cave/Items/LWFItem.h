//
//  LWFNewItem.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class LWFItemPrototype;

@interface LWFItem : SKSpriteNode

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) LWFItemPrototype *prototype;

@property (nonatomic) NSInteger quantity;

- (BOOL)isPotion;
- (BOOL)isGold;
- (BOOL)isEquipment;
- (BOOL)isProjectile;
- (BOOL)isUsable;
- (void)use;

- (BOOL)isStackable;
- (BOOL)canStackWith:(LWFItem *)item;
- (LWFItem *)stackWithItem:(LWFItem *)item;

- (UIImage *)getImage;
- (NSString *)getName;

@end
