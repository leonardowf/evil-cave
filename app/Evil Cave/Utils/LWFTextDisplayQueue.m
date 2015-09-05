//
//  LWFTextDisplayQueue.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/31/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFTextDisplayQueue.h"
#import "LWFMap.h"
#import "LWFCreature.h"

@interface LWFTextDisplayQueue () {
    LWFMap *_map;
    NSMutableArray *_producedItems;
    LWFCreature *_creature;
    dispatch_queue_t _serialQueue;
}
@end

@implementation LWFTextDisplayQueue

- (instancetype)initWithMap:(LWFMap *)map andCreature:(LWFCreature *)creature {
    self = [super init];
    if (self) {
        _map = map;
        _producedItems = [NSMutableArray new];
        _creature = creature;
        
        _serialQueue = dispatch_queue_create("com.example.CriticalTaskQueue", NULL);
    }
    return self;
}

- (void)displayLabel:(SKLabelNode *)label {
    label.position = _creature.position;
    
    [self produce:label];
    [self consume];
}

- (void)produce:(SKLabelNode *)label {
    [_producedItems addObject:label];
}

- (void)consume {
    dispatch_async(_serialQueue, ^{
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        SKLabelNode *first = [_producedItems firstObject];
        [_producedItems removeObject:first];
        
        [_map addChild:first];
        
        
        SKAction *wait = [SKAction waitForDuration:0.4];
        
        SKAction *moveAction = [SKAction moveByX:0 y:70 duration:1.2];
        SKAction *fadeAction = [SKAction fadeAlphaTo:0 duration:0.2];
        SKAction *sequenceAction = [SKAction sequence:@[moveAction, fadeAction]];
        
        [first runAction:sequenceAction completion:^{
            
            
            
        }];
        
        [first runAction:wait completion:^{
            dispatch_semaphore_signal(sem);
        }];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    });
}


@end
