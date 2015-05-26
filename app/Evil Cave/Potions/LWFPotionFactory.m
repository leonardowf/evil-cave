//
//  LWFPotionFactory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFPotionFactory.h"
#import "LWFHealthPotion.h"

@interface LWFPotionFactory () {
    NSMutableDictionary *_prototypes;
}
@end

@implementation LWFPotionFactory

SINGLETON_FOR_CLASS(PotionFactory)

- (instancetype)init {
    self = [super init];
    if (self) {
        _prototypes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)loadPrototypes {
    [_prototypes setObject:[LWFHealthPotion new] forKey:@"health_potion"];
}



@end
