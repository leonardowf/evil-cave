//
//  LWFNodeCompletionWithKeyCategory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFNodeCompletionWithKeyCategory.h"

@implementation SKNode (LWFNodeCompletionWithKeyCategory)
- (void)runAction:(SKAction *)action withKey:(NSString *)key completion:(void(^)(void))block {
    
    SKAction *completion = [SKAction runBlock:^{
        [block invoke];
    }];
    SKAction *sequence = [SKAction sequence:@[ action, completion ]];
    
    [self runAction:sequence withKey:key];
}
@end
