//
//  LWFItemFactory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWFNewItem;
@class LWFItemPrototype;

@interface LWFItemFactory : NSObject

- (LWFNewItem *)manufactureWithItemPrototype:(LWFItemPrototype *)itemPrototype;

@end