//
//  LWFGold.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFGold.h"

@implementation LWFGold

- (BOOL)isGold {
    return YES;
}

- (SKLabelNode *)getLabel {
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Munro"];
    label.fontSize = 20;

    UIColor *labelColor;
    labelColor = [UIColor colorWithRed:1.0 green:215.0/255.0 blue:0.0 alpha:1.0];

    [label setFontColor:labelColor];
    label.text = [NSString stringWithFormat:@"%ld", (long)self.quantity];

    return label;
}

@end
