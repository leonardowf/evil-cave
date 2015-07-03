//
//  LWFNodeCompletionWithKeyCategory.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKNode (LWFNodeCompletionWithKeyCategory)
- (void)runAction:(SKAction *)action withKey:(NSString *)key completion:(void(^)(void))block;
@end