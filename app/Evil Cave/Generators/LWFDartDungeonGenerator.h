//
//  LWFDartDungeonGenerator.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/28/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFDartDungeonGenerator : NSObject

- (instancetype)initForStageWidth:(NSInteger)stageWidth
                   andStageHeigth:(NSInteger)stageHeight;

- (void)generate;

@property (nonatomic, strong) NSMutableArray *stage;

@end
