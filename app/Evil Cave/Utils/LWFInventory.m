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
#import "LWFPlayer.h"
#import "LWFEquips.h"

@interface LWFInventory () {
    LWFViewController *_viewController;
    NSMutableArray *_imageViewHolders;
    UIView *_overlay;
    
    LWFItemDescription *_itemDescription;
}

@end
@implementation LWFInventory

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.money = 0;
        self.items = [NSMutableArray array];
        self.equips = [[LWFEquips alloc]init];
    }
    return self;
}

SINGLETON_FOR_CLASS(Inventory)

- (void)hide {
    if (_itemDescription != nil) {
        [_itemDescription removeFromSuperview:YES];
        _itemDescription = nil;
        return;
    }
    
    _overlay.hidden = YES;
    _viewController.viewInventoryContainer.alpha = 0.0;
}

- (void)hideItemDescriptionIfNeeded {
    if (_itemDescription != nil) {
        [_itemDescription removeFromSuperview:YES];
        _itemDescription = nil;
        return;
    }
}

- (void)show {
    _overlay.hidden = NO;
    [_viewController.view bringSubviewToFront:_viewController.viewInventoryContainer];
    _viewController.viewInventoryContainer.alpha = 1.0;
    
    _viewController.labelGold.text = [NSString stringWithFormat:@"%ld", (long)self.money];
}

- (BOOL)isEquipped:(LWFItem *)item {
    return [_equips isEquiped:item];
}

- (BOOL)canTakeItem:(LWFItem *)item {
    return YES;
    // TODO
}

- (void)takeItem:(LWFItem *)item {
    [LWFLogger logPickedItem:item];
    
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
    [self hideItemDescriptionIfNeeded];
    
    UIImageView *imageView = (UIImageView *)[sender view];
    LWFImageViewHolder *viewHolder = [self viewHolderForImageView:imageView];
    
    if (viewHolder.item != nil) {
        [self openItemDescription:viewHolder.item];
    }
}

- (void)openItemDescription:(LWFItem *)item {
    if (_itemDescription != nil) {
        [_itemDescription removeFromSuperview:true];
    }
    
    LWFItemComparison *comparison = [self.equips compareToRespectiveEquipped:item];
    
    _itemDescription = [[LWFItemDescription alloc]initWithItem:item itemComparison:comparison andInventory:self];
    [_itemDescription addToView:_viewController.view];
}

- (LWFImageViewHolder *)viewHolderForImageView:(UIImageView *)imageView {
    for (LWFImageViewHolder *viewHolder in _imageViewHolders) {
        if (imageView == viewHolder.imageView) {
            return viewHolder;
        }
    }
    
    return nil;
}

- (LWFImageViewHolder *)viewHolderForItem:(LWFItem *)item {
    for (LWFImageViewHolder *viewHolder in _imageViewHolders) {
        if (item == viewHolder.item) {
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
    _overlay = viewController.viewInventoryOverlay;
    
    for (NSInteger i = 1; i <= 15; i++) {
        NSString *imageViewToGet = [NSString stringWithFormat:@"item%ld", i];
        id imageView = [viewController valueForKey:imageViewToGet];
        
        [self addGestureRecognizesToImageView:imageView];
        
        LWFImageViewHolder *imageViewHolder = [[LWFImageViewHolder alloc]init];
        imageViewHolder.imageView = imageView;
        [_imageViewHolders addObject:imageViewHolder];
    }
    
    
    UITapGestureRecognizer *tapArmor = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapArmor)];
    UITapGestureRecognizer *tapBoots = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBoots)];
    UITapGestureRecognizer *tapAccessory = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapAccessory)];
    UITapGestureRecognizer *tapWeapon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapWeapon)];
    
    [viewController.imageViewWeapon setUserInteractionEnabled:YES];
    [viewController.imageViewWeapon addGestureRecognizer:tapWeapon];
    
    [viewController.imageViewArmor setUserInteractionEnabled:YES];
    [viewController.imageViewArmor addGestureRecognizer:tapArmor];
    
    [viewController.imageViewBoots setUserInteractionEnabled:YES];
    [viewController.imageViewBoots addGestureRecognizer:tapBoots];
    
    [viewController.imageViewAccessory setUserInteractionEnabled:YES];
    [viewController.imageViewAccessory addGestureRecognizer:tapAccessory];
}

- (void)didTapWeapon {
    if (self.equips.weapon != nil) {
        [self openItemDescription:self.equips.weapon];
    }
}

- (void)didTapArmor {
    if (self.equips.armor != nil) {
        [self openItemDescription:self.equips.armor];
    }
}

- (void)didTapBoots {
    if (self.equips.boots != nil) {
        [self openItemDescription:self.equips.boots];
    }
}

- (void)didTapAccessory {
    if (self.equips.accessory != nil) {
        [self openItemDescription:self.equips.accessory];
    }
}

- (BOOL)isOpen {
    return _viewController.viewInventoryContainer.alpha == 1.0;
}

- (void)equip:(LWFItem *)item {
    // Verifica se está tentando equipar um item que não está no inventário
    // for some reason...
    if (![_items containsObject:item]) {
        return;
    }
    
    LWFItem *replaced = [self.equips equip:item];
    
    LWFImageViewHolder *viewHolder = [self viewHolderForItem:item];
    
    [self changeEquipsContainerFor:item withAction:YES];
    
    viewHolder.item = replaced;
    viewHolder.imageView.image = [replaced getImage];
    
    NSMutableArray *wtf = [NSMutableArray array];
    
    NSArray *items = _items;
    for (LWFItem *aItem in items) {
        if (aItem != item) {
            [wtf addObject:aItem];
        }
    }
    
    _items = wtf;
    
    if (replaced != nil) {
        [_items addObject:replaced];        
    }
}

- (void)changeEquipsContainerFor:(LWFItem *)item withAction:(BOOL)equipping {
    NSString *imageName = @"";
    UIImageView *imageViewToReplace = nil;
    UIImageView *backgroundImageViewToReplace = nil;
    UIImage *imageToReplace = nil;
    
    if ([item isWeapon]) {
        imageName = @"weapon_empty";
        imageViewToReplace = _viewController.imageViewWeapon;
        backgroundImageViewToReplace = _viewController.imageViewWeaponBackground;
    }
    
    if (equipping) {
        imageName = @"thumb";
        imageToReplace = [item getImage];
    }
    
    imageViewToReplace.image = imageToReplace;
    backgroundImageViewToReplace.image = [UIImage imageNamed:imageName];
}

- (void)unequip:(LWFItem *)item {
    [_equips unequip:item];
    
    [self changeEquipsContainerFor:item withAction:NO];
    
    if ([self canTakeItem:item]) {
        [self takeItem:item];
    } else {
        [self drop:item];
    }
}

- (void)drop:(LWFItem *)item {
    _itemDescription = nil;
    
    if ([_items containsObject:item]) {
        [self dropStoredItem:item];
    } else {
        [self dropEquippedItem:item];
    }
    
    _itemDescription = nil;
    
    [self hide];
    [self dropOnGround:item];

}

- (void)dropStoredItem:(LWFItem *)item {
    NSMutableArray *wtf = [NSMutableArray array];
    
    NSArray *items = _items;
    for (LWFItem *aItem in items) {
        if (aItem != item) {
            [wtf addObject:aItem];
        }
    }
    
    _items = wtf;
    
    LWFImageViewHolder *viewHolder = [self viewHolderForItem:item];
    viewHolder.item = nil;
    viewHolder.imageView.image = nil;
    
}

- (void)dropEquippedItem:(LWFItem *)item {
    [self changeEquipsContainerFor:item withAction:NO];
    
    if (self.equips.weapon == item) {
        self.equips.weapon = nil;
        _viewController.imageViewWeapon.image = nil;
        return;
    }
    
    if (self.equips.armor == item) {
        self.equips.armor = nil;
        _viewController.imageViewArmor.image = nil;
        return;
    }
    
    if (self.equips.boots == item) {
        self.equips.boots = nil;
        _viewController.imageViewBoots.image = nil;
        return;
    }
    
    if (self.equips.accessory == item) {
        self.equips.accessory = nil;
        _viewController.imageViewAccessory.image = nil;
        return;
    }
}

- (void)dropOnGround:(LWFItem *)item {
    self.player = [LWFPlayer sharedPlayer];
    
    [self.player.currentTile addChild:item];
    [self.player.currentTile steppedOnTile:self.player];
}


@end
