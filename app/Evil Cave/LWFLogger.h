//
//  LWFLogger.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFCreature;

@interface LWFLogger : NSObject

+ (void)logAttack:(LWFCreature *)creature damage:(NSInteger)damage;

@end
