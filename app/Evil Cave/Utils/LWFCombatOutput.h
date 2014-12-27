//
//  LWFCombatOutput.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LWFCombatOutputTypeHit,
    LWFCombatOutputTypeMiss
} LWFCombatOutputType;

@class SKLabelNode;

@interface LWFCombatOutput : NSObject

@property (nonatomic) NSUInteger damage;
@property (nonatomic) LWFCombatOutputType combatOutputType;

- (NSString *)getDamageString;
- (SKLabelNode *)getLabel;

@end
