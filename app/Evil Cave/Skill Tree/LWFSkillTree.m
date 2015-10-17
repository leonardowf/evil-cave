//
//  LWFSkillTree.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/12/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFSkillTree.h"

#import "LWFProgressionFunctionFactory.h"
#import "LWFProgressionFunction.h"

@interface LWFSkillTree () {
    LWFProgressionFunctionFactory *_factory;
}
@end

@implementation LWFSkillTree

- (instancetype)init
{
    self = [super init];
    if (self) {
        _factory = [LWFProgressionFunctionFactory new];
    }
    return self;
}

SINGLETON_FOR_CLASS(SkillTree)

- (NSInteger)nextPriceForSkill:(LWFSkillType)skillType atCurrentLevel:(NSInteger)currentLevel {
    NSInteger newLevel = currentLevel + 1;
    LWFProgressionFunction *progressFunction = [_factory priceFunctionForSkillType:skillType];
    
    return [progressFunction calculateForInput:newLevel];
}

- (NSInteger)nextHPPrice {
    return [self nextPriceForSkill:LWFSkillTypeHPPlus atCurrentLevel:self.HPLevel];
}

@end
