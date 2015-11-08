//
//  LWFRequisite.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 10/11/15.
//  Copyright © 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFRequisite : NSObject

@property (nonatomic, strong) NSMutableArray *andRequisites;
@property (nonatomic, strong) NSMutableArray *orRequisites;

- (BOOL)isMet;
- (NSString *)toMetDescription;

@end
