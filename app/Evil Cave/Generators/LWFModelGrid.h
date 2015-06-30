//
//  LWFModelGrid.h
//  Evil Cave
//
//  Created by Leonardo on 11/19/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFModelGrid : NSObject

@property (nonatomic, strong) NSMutableArray *model;
@property (nonatomic) CGPoint startLevelPosition;
@property (nonatomic) CGPoint endLevelPosition;
@property (nonatomic, strong) NSMutableArray *rooms;

@end
