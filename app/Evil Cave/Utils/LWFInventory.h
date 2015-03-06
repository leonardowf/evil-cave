//
//  LWFInventory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class LWFPlayer;
@class LWFItem;
@class LWFViewController;

@interface LWFInventory : SKSpriteNode

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) LWFPlayer *player;
@property (nonatomic) NSInteger money;

+ (id)sharedInventory;

- (void)show;
- (void)hide;
- (BOOL)canTakeItem:(LWFItem *)item;
- (void)inject:(LWFViewController *)viewController;
- (BOOL)isOpen;

@end
