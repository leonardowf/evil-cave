//
//  LWFTextDisplayQueue.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/31/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class LWFMap;

@interface LWFTextDisplayQueue : NSObject

- (void)displayLabel:(SKLabelNode *)label;
- (instancetype)initWithMap:(LWFMap *)map andCreature:(LWFCreature *)creature;

@end
