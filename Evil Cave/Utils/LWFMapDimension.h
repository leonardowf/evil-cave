//
//  LWFMapDimension.h
//  Evil Cave
//
//  Created by Leonardo on 11/15/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFMapDimension : NSObject

@property (nonatomic, readonly) NSInteger numberTilesVertical;
@property (nonatomic, readonly) NSInteger numberTilesHorizontal;
@property (nonatomic, readonly) CGSize tileSize;
@property (nonatomic, readonly) CGSize gridSize;

- (instancetype)initWithGridSize:(CGSize)gridSize
             numberTilesVertical:(NSInteger)numberTilesVertical
           numberTilesHorizontal:(NSInteger)numberTilesHorizontal
                     andTileSize:(float)tileSize;

@end
