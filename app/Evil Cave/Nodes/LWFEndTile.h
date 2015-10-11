//
//  LWFEndTile.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import "LWFTile.h"
@class LWFRequisite;

@interface LWFEndTile : LWFTile

@property (nonatomic, strong) LWFRequisite *walkRequisite;

- (BOOL)walkRequisitesAreMet;


@end
