//
//  LWFLogger.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFCreature;
@class LWFItem;

@interface LWFLogger : NSObject

+ (void)logAttackedCreature:(LWFCreature *)creature damage:(NSInteger)damage;
+ (void)logAttackedBy:(LWFCreature *)creature damage:(NSInteger)damage;
+ (void)logGold:(NSInteger)quantity;
+ (void)logPickedItem:(LWFItem *)item;

@end
