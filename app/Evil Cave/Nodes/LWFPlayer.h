//
//  LWFPlayer.h
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LWFMoveable.h"
#import "LWFCreature.h"

@class LWFTile;
@class LWFInventory;
@class LWFItem;

@interface LWFPlayer : LWFCreature

@property (nonatomic, strong) LWFInventory *inventory;

- (void)movementRequestIsInvalid;
- (void)cancelPreExistingActions;
- (void)takeItem:(LWFItem *)item;
- (void)requestTakeItem;

@end
