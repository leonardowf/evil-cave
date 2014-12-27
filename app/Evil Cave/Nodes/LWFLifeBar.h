//
//  LWFLifeBar.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/27/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class LWFStats;

@interface LWFLifeBar : SKSpriteNode

@property (nonatomic, strong) LWFStats *stats;

- (void)draw;

@end
