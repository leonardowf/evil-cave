//
//  LWFCreatureDeadRequisite.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFRequisite.h"

@class LWFCreature;

@interface LWFCreatureDeadRequisite : LWFRequisite

@property (nonatomic, strong) LWFCreature *creature;

- (instancetype)initWithCreature:(LWFCreature *)creature;

@end
