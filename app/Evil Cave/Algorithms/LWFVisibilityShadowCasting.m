//
//  LWFVisibilityShadowCasting.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/3/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFVisibilityShadowCasting.h"

@interface LWFVisibilityShadowCasting () {
    NSMutableArray *_visibleTiles;
}
@end

@implementation LWFVisibilityShadowCasting

- (instancetype)init
{
    self = [super init];
    if (self) {
        _visibleTiles = [NSMutableArray array];
    }
    return self;
}

- (void)lightTile:(LWFTile *)tile {
    [_visibleTiles addObject:tile];
}

- (BOOL)isTileInSight:(LWFTile *)tile {
    return ([_visibleTiles containsObject:tile]);
}

- (NSMutableArray *)getVisibleTiles {
    return _visibleTiles;
}

- (BOOL)shouldExecuteAsync {
    return NO;
}

@end
