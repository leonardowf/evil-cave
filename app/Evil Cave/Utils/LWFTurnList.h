//
//  LWFTurnList.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/26/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCreature.h"

@interface LWFTurnList : LWFCreature

@property NSMutableArray *creatures;

- (void)creatureFinishedTurn:(LWFCreature *)creature;

@end
