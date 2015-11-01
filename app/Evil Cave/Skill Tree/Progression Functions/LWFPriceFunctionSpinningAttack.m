//
//  LWFPriceFunctionSpinningAttack.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/16/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFPriceFunctionSpinningAttack.h"

@implementation LWFPriceFunctionSpinningAttack

- (NSInteger)calculateForInput:(NSInteger)input {
    if (input <= 0) {
        return 0;
    }
    
    return input * 50 + [self calculateForInput:input - 3];
}
@end
