//
//  LWFHudLogger.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFViewController;

@interface LWFHudLogger : NSObject

+ (id)sharedHudLogger;
- (void)inject:(LWFViewController *)viewController;

- (void)log:(NSString *)message;

@end
