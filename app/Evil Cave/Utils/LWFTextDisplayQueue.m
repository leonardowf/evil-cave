//
//  LWFTextDisplayQueue.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/31/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFTextDisplayQueue.h"
#import "LWFMap.h"

@interface LWFTextDisplayQueue () {
    LWFMap *_map;
    NSMutableArray *_producedItems;
    dispatch_queue_t _serialQueue;
}
@end

@implementation LWFTextDisplayQueue

- (instancetype)initWithMap:(LWFMap *)map {
    self = [super init];
    if (self) {
        _map = map;
        _producedItems = [NSMutableArray new];
        
        _serialQueue = dispatch_queue_create("com.example.CriticalTaskQueue", NULL);
    }
    return self;
}

//- (void)displayLabel:(SKLabelNode *)label atPosition:(CGPoint)position {
//    [_queue addObject:label];
//    
//    @synchronized(_queue) {
//        SKLabelNode *first = [_queue firstObject];
//        
//        first.position = position;
//        
//        [_map addChild:first];
//        
//        SKAction *action = [SKAction moveByX:0 y:70 duration:1.2];
//        [first runAction:action completion:^{
//            SKAction *action = [SKAction fadeAlphaTo:0 duration:0.2];
//            [first runAction:action completion:^{
//                [_queue removeObject:first];
//            }];
//            
//        }];
//    }
//}

- (void)displayLabel:(SKLabelNode *)label atPosition:(CGPoint)position {
    label.position = position;
    
    [self produce:label];
    [self consume];
}

- (void)produce:(SKLabelNode *)label {
    dispatch_async(_serialQueue, ^{
        [_producedItems addObject:label];
    });
}

- (void)consume {
    dispatch_async(_serialQueue, ^{
        
        SKLabelNode *first = [_producedItems firstObject];
        [_producedItems removeObject:first];

        [_map addChild:first];

        SKAction *action = [SKAction moveByX:0 y:70 duration:1.2];
        [first runAction:action completion:^{
            SKAction *action = [SKAction fadeAlphaTo:0 duration:0.2];
            [first runAction:action completion:^{
                
            }];
            
        }];
    });
}


@end
