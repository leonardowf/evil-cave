//
//  LWFChartboostHandler.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 7/20/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFChartboostHandler.h"

#import <Chartboost/Chartboost.h>
#import <Chartboost/CBNewsfeed.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import "LWFNotifications.h"

@implementation LWFChartboostHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        [Chartboost startWithAppId:@"55a9a25704b016792b35108c"
                      appSignature:@"20bf02427df8a24860b14a5fdbf2344ae805c828"
                          delegate:self];
    }
    return self;
}

- (void)didDismissInterstitial:(CBLocation)location {
    [self postNotification:NotificationDidDismissInterstitial withObject:nil];
}

- (void)didFailToLoadInterstitial:(CBLocation)location withError:(CBLoadError)error {
    [self postNotification:NotificationInterstitalDidFail withObject:nil];
    
}

- (void)postNotification:(NSString *)notificationName withObject:(id)object {
    [[NSNotificationCenter defaultCenter]postNotificationName:notificationName object:object];
}

@end
