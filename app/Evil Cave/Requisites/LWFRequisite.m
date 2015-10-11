//
//  LWFRequisite.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFRequisite.h"

@implementation LWFRequisite

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.andRequisites = [NSMutableArray new];
        self.orRequisites = [NSMutableArray new];
    }
    return self;
}

- (BOOL)isMet {
    for (LWFRequisite *requisite in self.andRequisites) {
        if (![requisite isMet]) {
            return NO;
        }
    }
    
    for (LWFRequisite *requisite in self.orRequisites) {
        if ([requisite isMet]) {
            return YES;
        }
    }
    
    if (self.andRequisites > 0) {
        return YES;
    }
    
    if (self.orRequisites > 0) {
        return NO;
    }
    
    return YES;
    
}

@end
