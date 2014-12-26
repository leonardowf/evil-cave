//
//  LWFKillable.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/26/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LWFKillable <NSObject>

- (void)statsChanged;
- (void)willDieWithCompletion:(void(^)(void))someBlock;
- (void)isDyingWithCompletion:(void(^)(void))someBlock;
- (void)diedWithCompletion:(void(^)(void))someBlock;

@end
