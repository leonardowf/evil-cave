//
//  LWFNewItemDescription.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 6/9/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWFPotion;
@class LWFInventory;

@interface LWFNewItemDescription : UIView

- (void)addToView:(UIView *)view;
- (void)removeFromSuperview:(BOOL)animated;

- (UIView *)getView;
- (UIView *)getContainerView;
- (NSString *)getNibName;

@end
