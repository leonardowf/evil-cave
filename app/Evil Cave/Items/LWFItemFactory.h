//
//  LWFItemFactory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWFItem;
@class LWFItemPrototype;

@interface LWFItemFactory : NSObject

- (LWFItem *)manufactureWithItemPrototype:(LWFItemPrototype *)itemPrototype;

@end
