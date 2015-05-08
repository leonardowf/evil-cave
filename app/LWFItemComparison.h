//
//  LWFItemComparison.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/15/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFEquipment.h"

@interface LWFItemComparison : NSObject

@property NSInteger strength;
@property NSInteger hp;
@property NSInteger minimumDamage;
@property NSInteger maximumDamage;


+ (LWFItemComparison *)compare:(LWFEquipment *)equipment1 withEquipment:(LWFEquipment *)equipment2;

@end
