//
//  LWFCaveGenerator.h
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFCaveGeneratorConstants.h"
#import "LWFCaveGeneratorCell.h"

@interface LWFCaveGenerator : NSObject

@property (assign, nonatomic) CGFloat chanceToBecomeWall;

- (instancetype)initWithHeight:(NSUInteger)heigth width:(NSUInteger)width;
- (NSMutableArray *)generate;


@end
