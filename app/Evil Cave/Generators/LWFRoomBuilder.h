//
//  LWFRoomBuilder.h
//  Evil Cave
//
//  Created by Leonardo on 11/17/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFRoom;

@interface LWFRoomBuilder : NSObject

@property (nonatomic) NSUInteger minWidth;
@property (nonatomic) NSUInteger maxWidth;
@property (nonatomic) NSUInteger minHeigth;
@property (nonatomic) NSUInteger maxHeigth;

- (instancetype)initWithMinWidth:(NSUInteger)minWidth
                        maxWidth:(NSUInteger)maxWidth
                       minHeigth:(NSUInteger)minHeigth
                    andMaxHeigth:(NSUInteger)maxHeigth;

-(LWFRoom *)build;

@end
