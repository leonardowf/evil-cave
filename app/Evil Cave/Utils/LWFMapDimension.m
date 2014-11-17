//
//  LWFMapDimension.m
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFMapDimension.h"

@implementation LWFMapDimension

- (instancetype)initWithGridSize:(CGSize)gridSize
             numberTilesVertical:(NSInteger)numberTilesVertical
           numberTilesHorizontal:(NSInteger)numberTilesHorizontal
                     andTileSize:(float)tileSize
{
    self = [super init];
    if (self) {
        _numberTilesVertical = numberTilesVertical;
        _numberTilesHorizontal = numberTilesHorizontal;
        _gridSize = gridSize;
        
        _tileSize = CGSizeMake(tileSize, tileSize);
        
    }
    return self;
}

@end
