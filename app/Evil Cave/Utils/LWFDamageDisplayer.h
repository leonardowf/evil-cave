//
//  LWFDamageDisplayer.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/3/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFMap;
@class LWFTile;

@interface LWFDamageDisplayer : NSObject

+ (id)sharedLWFDamageDisplayer;

@property NSString *name;
@property LWFMap *map;

- (void)showString:(NSString *)string atTile:(LWFTile *)tile;

@end
