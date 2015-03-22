//
//  LWFLifeDisplayer.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/22/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFStats;

@protocol LWFLifeDisplayer <NSObject>

- (void)setStats:(LWFStats *)stats;
- (void)draw;

@end
