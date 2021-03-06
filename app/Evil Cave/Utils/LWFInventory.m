//
//  LWFInventory.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFInventory.h"
#import "LWFViewController.h"
#import "LWFImageViewHolder.h"

#import "LWFNewItemDescription.h"
#import "LWFItemDescription.h"
#import "LWFPotionDescription.h"

#import "LWFPlayer.h"
#import "LWFEquips.h"

#import <pop/POP.h>
#import "LWFPotion.h"
#import "LWFItemRange.h"
#import "LWFMap.h"
#import "LWFGameController.h"
#import "LWFStats.h"
#import "LWFSoundPlayer.h"

@interface LWFInventory () {
    LWFViewController *_viewController;
    NSMutableArray *_imageViewHolders;
    UIView *_overlay;
    
    LWFNewItemDescription *_newItemDescription;
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
        self.player = [LWFPlayer sharedPlayer];
    }
    return self;
}

SINGLETON_FOR_CLASS(Inventory)

- (void)hide {
    if (_newItemDescription != nil) {
        [_newItemDescription removeFromSuperview:YES];
        _newItemDescription = nil;
        return;
    }
    
    _overlay.hidden = YES;
    _viewController.viewInventoryContainer.alpha = 0.0;
}

- (void)hideItemDescriptionIfNeeded {
    if (_newItemDescription != nil) {
        [_newItemDescription removeFromSuperview:YES];
        _newItemDescription = nil;
        return;
    }
}

- (void)show {
    _overlay.hidden = NO;
    [_viewController.view bringSubviewToFront:_viewController.viewInventoryContainer];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);
    opacityAnimation.beginTime = CACurrentMediaTime() + 0.1;
    [_viewController.viewInventoryContainer.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    _viewController.labelGold.text = [NSString stringWithFormat:@"%ld gold", (long)self.money];
}

- (BOOL)isEquipped:(LWFEquipment *)equipment {
    return [_equips isEquiped:equipment];
}

- (BOOL)canTakeItem:(LWFItem *)item {
    if ([item isStackable]) {
        LWFItem *foundItem = [self findSameKindStackable:item];
        
        if (foundItem != nil) {
            return YES;
        }
    }
    
    if (self.items.count >= STORED_ITEMS_LIMIT) {
        return NO;
    }
    
    return YES;
}

- (void)takeItem:(LWFItem *)item {
    if (![self canTakeItem:item]) {
        return;
    }
    
    [LWFLogger logPickedItem:item];
    
    if ([item isStackable]) {
        LWFItem *foundItem = [self findSameKindStackable:item];
        
        if (foundItem == nil) {
            [self.items addObject:item];
        } else {
            [foundItem stackWithItem:item];
        }
    } else {
        [self.items addObject:item];
    }
    
    [self displayItem:item];
}

- (void)displayItem:(LWFItem *)item {
    if (item.quantity == 0) {
        return;
    }
    
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
    
    [LWFSoundPlayer play:LWFSoundTypeUIClick];
    
    UIImageView *imageView = (UIImageView *)[sender view];
    LWFImageViewHolder *viewHolder = [self viewHolderForImageView:imageView];
    
    if (viewHolder.item != nil) {
        LWFItem *item = viewHolder.item;
        
        if ([item isEquipment]) {
            LWFEquipment *equipment = (LWFEquipment *)viewHolder.item;
            [self openItemDescription:equipment];
        } else if ([item isPotion]) {
            LWFPotion *potion = (LWFPotion *)item;
            [self openPotionDescription:potion];
        }
    }
}

- (void)openPotionDescription:(LWFPotion *)potion {
    NSLog(@"abrindo descrição de poção");
    
    if (_newItemDescription != nil) {
        [_newItemDescription removeFromSuperview];
    }
    
    _newItemDescription = [[LWFPotionDescription alloc]initWithItem:potion andInventory:self];
    [_newItemDescription addToView:_viewController.view];
}

- (void)openItemDescription:(LWFEquipment *)equipment {
    if (_newItemDescription != nil) {
        [_newItemDescription removeFromSuperview:true];
    }
    
    LWFItemComparison *comparison = [self.equips compareToRespectiveEquipped:equipment];
    
    _newItemDescription = [[LWFItemDescription alloc]initWithItem:equipment itemComparison:comparison andInventory:self];
    [_newItemDescription addToView:_viewController.view];
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
    
    for (NSInteger i = 0; i < STORED_ITEMS_LIMIT; i++) {
        NSString *imageViewToGet = [NSString stringWithFormat:@"item%ld", i];
        UIImageView * imageView = (UIImageView *)[viewController valueForKey:imageViewToGet];
        [self configurePixelImageView:imageView];
        
        [self addGestureRecognizesToImageView:imageView];
        
        LWFImageViewHolder *imageViewHolder = [[LWFImageViewHolder alloc]init];
        imageViewHolder.imageView = imageView;
        [_imageViewHolders addObject:imageViewHolder];
    }
    
    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapClose)];
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
    
    [viewController.imageViewButtonClose addGestureRecognizer:tapClose];
    
    NSArray *imageViewEquips = @[viewController.imageViewWeapon, viewController.imageViewArmor,
                            viewController.imageViewBoots, viewController.imageViewAccessory];
    
    for (UIImageView *imageView in imageViewEquips) {
        [self configurePixelImageView:imageView];
    }
}

- (void)configurePixelImageView:(UIImageView *)imageView {
    [imageView.layer setMagnificationFilter:kCAFilterNearest];
    [imageView.layer setMinificationFilter:kCAFilterNearest];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didTapClose {
    [LWFSoundPlayer play:LWFSoundTypeUIClick];
    [self hide];
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

- (void)equip:(LWFEquipment *)equipment {
    // Verifica se está tentando equipar um item que não está no inventário
    // for some reason...
    if (![_items containsObject:equipment]) {
        return;
    }
    
    NSInteger beforeEquipMaxHp = _player.stats.maxHP;
    LWFEquipment *replaced = [self.equips equip:equipment];
    NSInteger afterEquipMaxHP = _player.stats.maxHP;
    
    [self updateHPWithNewMax:afterEquipMaxHP andOldMax:beforeEquipMaxHp];
    
    LWFImageViewHolder *viewHolder = [self viewHolderForItem:equipment];
    
    [self changeEquipsContainerFor:equipment withAction:YES];
    
    viewHolder.item = replaced;
    viewHolder.imageView.image = [replaced getImage];
    
    NSMutableArray *wtf = [NSMutableArray array];
    
    NSArray *items = _items;
    for (LWFEquipment *aEquipment in items) {
        if (aEquipment != equipment) {
            [wtf addObject:aEquipment];
        }
    }
    
    _items = wtf;
    
    if (replaced != nil) {
        [_items addObject:replaced];        
    }
}

- (void)updateHPWithNewMax:(NSInteger)newMax andOldMax:(NSInteger)oldMax {
    CGFloat propotion = (float)newMax / (float)oldMax;
    
    CGFloat newHP = _player.stats.currentHP * propotion;
    NSInteger newHPRounded = newHP + 0.5;
    
    _player.stats.currentHP = newHPRounded;
    
    if (_player.stats.currentHP > _player.stats.maxHP) {
        _player.stats.currentHP = _player.stats.maxHP;
    }
    
    [_player statsChanged];
}

- (void)changeEquipsContainerFor:(LWFEquipment *)equipment withAction:(BOOL)equipping {
    NSString *imageName = @"";
    UIImageView *imageViewToReplace = nil;
    UIImageView *backgroundImageViewToReplace = nil;
    UIImage *imageToReplace = nil;
    
    if ([equipment isWeapon]) {
        imageName = @"weapon_empty";
        imageViewToReplace = _viewController.imageViewWeapon;
        backgroundImageViewToReplace = _viewController.imageViewWeaponBackground;
    }
    
    if (equipping) {
        imageName = @"thumb";
        imageToReplace = [equipment getImage];
    }
    
    imageViewToReplace.image = imageToReplace;
    backgroundImageViewToReplace.image = [UIImage imageNamed:imageName];
}

- (BOOL)canUnequip:(LWFEquipment *)equipment {
    return [self canTakeItem:equipment];
}

- (void)unequip:(LWFEquipment *)equipment {
    
    NSInteger beforeUnequipMaxHp = _player.stats.maxHP;
    [_equips unequip:equipment];
    NSInteger afterUnequipMaxHP = _player.stats.maxHP;
    
    [self updateHPWithNewMax:afterUnequipMaxHP andOldMax:beforeUnequipMaxHp];
    
    [self changeEquipsContainerFor:equipment withAction:NO];
    
    if ([self canTakeItem:equipment]) {
        [self takeItem:equipment];
    } else {
        [self drop:equipment];
    }
}

- (void)drop:(LWFItem *)item {
    _newItemDescription = nil;
    
    if ([_items containsObject:item]) {
        [self dropStoredItem:item];
    } else {
        
        if ([item isEquipment]) {
            LWFEquipment *equipment = (LWFEquipment *)item;
            
            NSInteger beforeDropMaxHP = _player.stats.maxHP;
            [self dropEquippedItem:equipment];
            NSInteger afterDropMaxHp = _player.stats.maxHP;
            [self updateHPWithNewMax:afterDropMaxHp andOldMax:beforeDropMaxHP];
        }
    }
    
    _newItemDescription = nil;
    
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

- (void)dropEquippedItem:(LWFEquipment *)item {
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

- (void)clear {
    [self.items removeAllObjects];
    self.equips.weapon = nil;
    self.equips.armor = nil;
    self.equips.boots = nil;
    self.equips.accessory = nil;
    self.money = 0;
    
    [self resetImageViewHolders];
    [self resetEquipmentsImageViews];
}

- (void)resetEquipmentsImageViews {
    _viewController.imageViewArmor.image = nil;
    _viewController.imageViewBoots.image = nil;
    _viewController.imageViewWeapon.image = [UIImage imageNamed:@"weapon_empty"];
    _viewController.imageViewAccessory.image = nil;
}

- (void)resetImageViewHolders {
    for (NSInteger i = 0; i < STORED_ITEMS_LIMIT; i++) {
        LWFImageViewHolder *viewHolder = [_imageViewHolders objectAtIndex:i];
        viewHolder.item = nil;
        viewHolder.imageView.image = nil;
    }
}

- (BOOL)isEmpty {
    if ([self.items count] != 0) {
        return NO;
    }
    
    if (self.equips.weapon != nil) {
        return NO;
    }
    
    if (self.equips.armor != nil) {
        return NO;
    }
    
    if (self.equips.boots != nil) {
        return NO;
    }
    
    if (self.equips.accessory != nil) {
        return NO;
    }
    
    return YES;
}

- (LWFItem *)findSameKindStackable:(LWFItem *)item {
    if (![item isStackable]) {
        return nil;
    }
    
    for (LWFItem *storedItem in self.items) {
        if ([storedItem isStackable] && [storedItem.identifier isEqualToString:item.identifier]) {
            return storedItem;
        }
    }
    
    return nil;
}

- (void)didUsePotion:(LWFPotion *)potion {
    LWFItem *sameKind = [self findSameKindStackable:potion];
    
    if (sameKind.quantity == 0) {
        [_items removeObject:sameKind];
        LWFImageViewHolder *viewHolder = [self viewHolderForItem:potion];
        viewHolder.imageView.image = nil;
        viewHolder.item = nil;
    }
    
    [[LWFPlayer sharedPlayer] finishTurn];
}

- (void)requestThrowItem:(LWFItem *)item {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    [self hideItemDescriptionIfNeeded];
    [self hide];
    
    LWFItemRange *itemRange = [[LWFItemRange alloc]initFromTile:player.currentTile forItem:item];
    
    itemRange.delegate = self;
    
    LWFMap *map = [[LWFGameController sharedGameController] map];
    [map.currentItemRange removeRangeOverlay];
    map.currentItemRange = itemRange;
}

- (void)didSelectTileInRange:(LWFTile *)tile forItem:(LWFItem *)item {
    if (item.quantity <= 0) {
        return;
    }
    
    [self animateThrowOfItem:item atTile:tile completion:^{
        if ([item isPotion]) {
            LWFPotion *potion = (LWFPotion *)item;
            
            [potion applyEffectOn:tile.creatureOnTile];
            
            [self didUsePotion:potion];
            
            [LWFLogger logThrewPotion:potion];
        }
    }];

}

- (void)animateThrowOfItem:(LWFItem *)item atTile:(LWFTile *)tile completion:(void(^)(void))someBlock {
    // Não faz sentido a classe inventório cuidar disso, mas não sei onde mais colocar
    
    LWFMap *map = [[LWFGameController sharedGameController] map];
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    SKSpriteNode *itemRepresentation = [SKSpriteNode spriteNodeWithTexture:[item texture]];
    itemRepresentation.position = player.position;
    [map addChild:itemRepresentation];
    SKAction *moveAction = [SKAction moveTo:tile.position duration:0.4];
    SKAction *rotateAction = [SKAction rotateByAngle: M_PI/4.0 duration:0.1];
    rotateAction = [SKAction repeatAction:rotateAction count:4];
    
    NSArray *actionGroup = @[moveAction, rotateAction];
    
    [itemRepresentation runAction:[SKAction group:actionGroup] completion:^{
        [itemRepresentation removeFromParent];
        [someBlock invoke];
    }];
}


@end
