//
//  LWFCaveGeneratorConstants.h
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFCaveGeneratorConstants : NSObject

typedef NS_ENUM(NSInteger, CaveCellType) {
    CaveCellTypeInvalid = -1,
    CaveCellTypeWall,
    CaveCellTypeFloor,
    CaveCellTypeStart,
    CaveCellTypeEnd,
    CaveCellTypeMax
};

@end
