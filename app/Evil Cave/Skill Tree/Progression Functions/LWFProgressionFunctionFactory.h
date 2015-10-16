//
//  LWFProgressionFunctionFactory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/15/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFSkillTree.h"

@class LWFProgressionFunction;

@interface LWFProgressionFunctionFactory : NSObject

- (LWFProgressionFunction *)priceFunctionForSkillType:(LWFSkillType)skillType;
- (LWFProgressionFunction *)statGrowthFunctionForSkillType:(LWFSkillType)skillType;

@end
