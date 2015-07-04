//
//  LWFChest.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/3/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFChest.h"

@interface LWFChest () {
    BOOL _open;
}
@end

@implementation LWFChest

- (BOOL)isOpen {
    return _open;
}

- (BOOL)isClosed {
    return !_open;
}

- (void)open {
    _open = YES;
}

@end
