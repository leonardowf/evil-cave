//
//  LWFImageViewHolder.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 3/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWFItem;


@interface LWFImageViewHolder : NSObject

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LWFItem *item;

@end
