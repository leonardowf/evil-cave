//
//  LWFCaveGeneratorCell.h
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFCaveGeneratorConstants.h"

@interface LWFCaveGeneratorCell : NSObject

@property NSUInteger x;
@property NSUInteger y;
@property CaveCellType cellType;

- (instancetype)initWithX:(NSUInteger)x y:(NSUInteger)y andType:(CaveCellType)type;

@end
