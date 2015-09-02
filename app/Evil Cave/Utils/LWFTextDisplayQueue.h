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

- (instancetype)initWithMap:(LWFMap *)map;
- (void)displayLabel:(SKLabelNode *)label atPosition:(CGPoint)position;

@end
