//
//  LWFHumbleBeeFindPath.h
//  Evil Cave
//
//  Created by Leonardo on 11/21/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWFTileMap;
@class LWFTile;

@interface LWFHumbleBeeFindPath : NSObject

@property LWFTileMap *tileMap;

-(NSArray *)findPath:(int)startX :(int)startY :(int)endX :(int)endY;

@end
