//
//  LWFItem.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class LWFItemPrototype;

@interface LWFItem : SKSpriteNode

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) NSNumber * lowdamage;
@property (nonatomic, strong) NSNumber * highdamage;
@property (nonatomic, strong) NSNumber * strength;
@property (nonatomic, strong) NSNumber * HP;
@property (nonatomic, strong) NSNumber * armor;

@property (nonatomic) NSInteger quantity;

@property (nonatomic, strong) LWFItemPrototype *prototype;

- (instancetype)initWithItemPrototype:(LWFItemPrototype *)prototype;

@end
