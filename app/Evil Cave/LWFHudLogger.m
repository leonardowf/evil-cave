//
//  LWFHudLogger.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFHudLogger.h"
#import "LWFViewController.h"

@interface LWFHudLogger () {
    UILabel *_labelLogLine1;
    UILabel *_labelLogLine2;
    UILabel *_labelLogLine3;
    
}
@end

@implementation LWFHudLogger

SINGLETON_FOR_CLASS(HudLogger)

- (void)log:(NSString *)message {
    _labelLogLine1.text = _labelLogLine2.text;
    _labelLogLine2.text = _labelLogLine3.text;
    _labelLogLine3.text = message;
}

- (void)inject:(LWFViewController *)viewController {
    _labelLogLine1 = viewController.labelLogLine1;
    _labelLogLine2 = viewController.labelLogLine2;
    _labelLogLine3 = viewController.labelLogLine3;
}

@end
