//
//  LWFEquips.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFItem;
@class LWFItemComparison;

@interface LWFEquips : NSObject

@property (nonatomic, strong) LWFItem *weapon;
@property (nonatomic, strong) LWFItem *armor;
@property (nonatomic, strong) LWFItem *boots;
@property (nonatomic, strong) LWFItem *accessory;

- (LWFItem *)equip:(LWFItem *)item;
- (LWFItemComparison *)compareToRespectiveEquipped:(LWFItem *)item;
- (LWFItemComparison *)compare:(LWFItem *)itemSrc toItem:(LWFItem *)itemDest;

@end
