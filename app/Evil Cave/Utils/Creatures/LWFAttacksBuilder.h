//
//  LWFAttacksBuilder.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/13/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFCreatureBuilder.h"

@interface LWFAttacksBuilder : NSObject

- (NSMutableArray *)attacksForCreatureType:(LWFCreatureType)creatureType;

@end
