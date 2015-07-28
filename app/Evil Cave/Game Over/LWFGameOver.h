//
//  LWFGameOver.h
//  Evil Cave
//
//  Created by Leonardo on 7/17/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "LWFGameOverButtons.h"

@interface LWFGameOver : NSObject <LWFGameOverButtonsDelegate>

+ (id)sharedGameOver;
- (void)start;

@end
