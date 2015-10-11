//
//  LWFEndTile.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFEndTile.h"
#import "LWFRequisite.h"

@implementation LWFEndTile

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.walkRequisite = [LWFRequisite new];
    }
    return self;
}

- (BOOL)walkRequisitesAreMet {
    return [self.walkRequisite isMet];
}


@end
