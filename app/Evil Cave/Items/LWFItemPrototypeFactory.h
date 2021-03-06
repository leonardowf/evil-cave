//
//  LWFItemPrototypeFactory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/24/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFItemPrototype;

@interface LWFItemPrototypeFactory : NSObject

+ (id)sharedItemPrototypeFactory;

@property (nonatomic, strong) NSDictionary *prototypes;

- (LWFItemPrototype *)getPrototypeWithName:(NSString *)name;

@end
