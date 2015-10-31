//
//  LWFGrowthFunctionSpinningAttack.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/17/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFGrowthFunctionSpinningAttack.h"

@implementation LWFGrowthFunctionSpinningAttack

- (NSInteger)calculateForInput:(NSInteger)input {
    if (input == 0) {
        return 0;
    }
    
    if (input == 1) {
        return 0;
    }
    
    return input - 1;
}

@end
