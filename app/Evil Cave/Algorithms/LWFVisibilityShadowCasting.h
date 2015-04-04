//
//  LWFVisibilityShadowCasting.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/3/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFShadowCasting.h"

@interface LWFVisibilityShadowCasting : LWFShadowCasting

- (BOOL)isTileInSight:(LWFTile *)tile;

@end
