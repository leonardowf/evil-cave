//
//  LWFCombatOutput.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/22/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCombatOutput.h"
#import <SpriteKit/SpriteKit.h>

@implementation LWFCombatOutput

- (NSString *)getDamageString {
    return [NSString stringWithFormat:@"%ld", (long)self.damage];
}

- (SKLabelNode *)getLabel {
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Munro"];
    label.fontSize = 20;
    
    UIColor *labelColor;
    NSString *labelText;
    
    if (self.combatOutputType == LWFCombatOutputTypeMiss) {
        labelColor = [UIColor yellowColor];
        labelText = @"miss";
    } else {
        labelColor = [UIColor whiteColor];
        labelText = [self getDamageString];
    }
    
    [label setFontColor:labelColor];
    label.text = labelText;
    
    return label;

}

@end
