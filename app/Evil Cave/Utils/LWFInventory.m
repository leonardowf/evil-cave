//
//  LWFInventory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFInventory.h"
#import "LWFItem.h"
#import "LWFViewController.h"
#import "LWFImageViewHolder.h"

#import "LWFItemDescription.h"

@interface LWFInventory () {
    LWFViewController *_viewController;
    NSMutableArray *_imageViewHolders;
}

@end
@implementation LWFInventory

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.money = 0;
        self.items = [NSMutableArray array];

    }
    return self;
}

SINGLETON_FOR_CLASS(Inventory)

- (void)hide {
    _viewController.viewInventoryContainer.alpha = 0.0;
}

- (void)show {
    _viewController.viewInventoryContainer.alpha = 1.0;
    
    _viewController.labelGold.text = [NSString stringWithFormat:@"%ld", (long)self.money];
}

- (BOOL)canTakeItem:(LWFItem *)item {
    return YES;
    // TODO
}

- (void)takeItem:(LWFItem *)item {
    [self.items addObject:item];
    
    [self displayItem:item];
}

- (void)displayItem:(LWFItem *)item {
    LWFImageViewHolder *imageViewHolder = [self getImageViewContainer];
    
    if (imageViewHolder != nil) {
        imageViewHolder.item = item;
        UIImage *image = [item getImage];

        [imageViewHolder.imageView setImage:image];
    }
    
}

- (void)addGestureRecognizesToImageView:(UIImageView *)imageView {
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    [imageView addGestureRecognizer:tapGR];
}

- (void)didTap:(id)sender {
    
    UIImageView *imageView = (UIImageView *)[sender view];
    LWFImageViewHolder *viewHolder = [self viewHolderForImageView:imageView];
    
    NSLog(@"tocou");
    
    
    LWFItemDescription *itemDescription = [[LWFItemDescription alloc]init];
    
    itemDescription.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_viewController.view addSubview:itemDescription];
    
    NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:itemDescription.containerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-60];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:itemDescription.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:60];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:itemDescription.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [_viewController.view addConstraint:c0];
    [_viewController.view addConstraint:c1];
    [_viewController.view addConstraint:c2];
    
}

- (LWFImageViewHolder *)viewHolderForImageView:(UIImageView *)imageView {
    for (LWFImageViewHolder *viewHolder in _imageViewHolders) {
        if (imageView == viewHolder.imageView) {
            return viewHolder;
        }
    }
    
    return nil;
}

- (LWFImageViewHolder *)getImageViewContainer {
    for (LWFImageViewHolder *imageViewHolder in _imageViewHolders) {
        if (imageViewHolder.item == nil) {
            return imageViewHolder;
        }
    }
    return nil;
}

- (void)inject:(LWFViewController *)viewController {
    _viewController = viewController;
    _imageViewHolders = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 15; i++) {
        NSString *imageViewToGet = [NSString stringWithFormat:@"item%ld", i];
        id imageView = [viewController valueForKey:imageViewToGet];
        
        [self addGestureRecognizesToImageView:imageView];
        
        LWFImageViewHolder *imageViewHolder = [[LWFImageViewHolder alloc]init];
        imageViewHolder.imageView = imageView;
        [_imageViewHolders addObject:imageViewHolder];
    }
}

- (BOOL)isOpen {
    return _viewController.viewInventoryContainer.alpha == 1.0;
}


@end
