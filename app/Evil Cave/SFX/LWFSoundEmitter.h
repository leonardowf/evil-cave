//
//  LWFSoundEmitter.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 9/7/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWFSoundTypes.h"

@protocol LWFSoundEmitter <NSObject>

- (NSString *)getSoundName:(LWFSoundType)soundType;

@end
