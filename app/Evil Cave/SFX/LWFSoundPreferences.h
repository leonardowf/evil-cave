//
//  LWFSoundPreferences.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 8/16/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFSoundPreferences : NSObject

@property (nonatomic) CGFloat volume;
@property (nonatomic) BOOL soundMuted;
@property (nonatomic) BOOL musicMuted;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end
