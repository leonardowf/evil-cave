//
//  LWFCreature.h
//  Evil Cave
//
//  Created by Leonardo on 11/20/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LWFMoveable.h"

@class LWFMovementManager;

@interface LWFCreature : SKSpriteNode <LWFMoveable>

@property (nonatomic, strong) LWFMovementManager *movementManager;

@end
