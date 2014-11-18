//
//  LWFCaveGeneratorCell.m
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCaveGeneratorCell.h"

@implementation LWFCaveGeneratorCell

- (instancetype)initWithX:(NSUInteger)x y:(NSUInteger)y andType:(CaveCellType)type;
{
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
        self.cellType = type;
    }
    return self;
}

@end
