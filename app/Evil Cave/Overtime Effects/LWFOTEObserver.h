//
//  LWFOTEObserver.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/26/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFOTE;

@protocol LWFOTEObserver <NSObject>

- (void)notifyAdditionOf:(LWFOTE *)ote;
- (void)notify:(LWFOTE *)ote turnsLeftChangedTo:(NSInteger)newTurnsLeft;
- (void)notifyWillBeRemoved:(LWFOTE *)ote;
- (void)notifyRemovalOf:(LWFOTE *)ote;
- (void)notifyOTEActivated:(LWFOTE *)ote;

@end
