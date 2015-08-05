//
//  LWFPieView.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPieView.h"

@implementation LWFPieView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.colorBackAlpha = [UIColor redColor];
        self.fillColor = [UIColor yellowColor];
        self.progress = 0.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor redColor];
    CGRect allRect = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect circleRect = CGRectInset(allRect, 2.0f, 2.0f);
    
    CGColorRef colorBackAlpha = CGColorCreateCopyWithAlpha([UIColor redColor]. CGColor, 0.1f);
    
    [self.fillColor setStroke];
    CGContextSetFillColorWithColor(context, colorBackAlpha);
    
    CGContextSetLineWidth(context, 2.0f);
    CGContextFillEllipseInRect(context, circleRect);
    CGContextStrokeEllipseInRect(context, circleRect);
    
    CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
    CGFloat radius = (allRect.size.width - 4) / 2 - 3;
    CGFloat startAngle = - ((float)M_PI / 2);
    CGFloat endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
    [[UIColor redColor] setFill];
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end
