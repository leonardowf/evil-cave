//
//  LWFPointObject.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/14/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFPointObject : NSObject

@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;

+ (LWFPointObject *)pointWithX:(NSInteger)x andY:(NSInteger)y;

@end