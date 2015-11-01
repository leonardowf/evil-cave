//
//  LWFPriceFunctionStrengthPlus.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/16/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFPriceFunctionStrengthPlus.h"

@implementation LWFPriceFunctionStrengthPlus

- (NSInteger)calculateForInput:(NSInteger)input {
    if (input <= 0) {
        return 0;
    }
    
    return input * 30 + [self calculateForInput:input - 3];
}

@end
