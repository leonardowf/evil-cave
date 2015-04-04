//
//  LWFShadowCasting.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 2/21/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFTile;

@interface LWFShadowCasting : NSObject

- (void)doFovStartX:(NSInteger)startX startY:(NSInteger)startY radius:(NSInteger)radius;
- (void)lightTile:(LWFTile *)tile;
@end
