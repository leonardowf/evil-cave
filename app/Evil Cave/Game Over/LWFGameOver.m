//
//  LWFGameOver.m
//  Evil Cave
//
//  Created by Leonardo on 7/17/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFGameOver.h"
#import "LWFGameController.h"
#import "LWFMap.h"
#import "LWFTileMap.h"
#import "LWFTile.h"
#import "LWFViewController.h"
#import "LWFHudLifebar.h"
#import "LWFPlayer.h"
#import "LWFGameOverTitle.h"
#import "LWFNotifications.h"
#import "LWFGameOverStats.h"
#import "LWFGameOverButtons.h"
#import "LWFStats.h"
#import "LWFOTEQueue.h"

#import <Chartboost/Chartboost.h>
#import "LWFInventory.h"
#import "LWFPotionFactory.h"
#import "LWFSoundPlayer.h"
#import "LWFSkillTreeController.h"
#import <POPAnimation.h>
#import <POPBasicAnimation.h>

@interface LWFGameOver () {
    LWFGameOverTitle *_title;
    LWFGameOverStats *_gameOverStats;
    LWFGameOverButtons *_gameOverButtons;
    
    NSTimer *_adErrorTimer;
}

@end

@implementation LWFGameOver

SINGLETON_FOR_CLASS(GameOver)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self subscribeToNotifications];
    }
    return self;
}

- (void)subscribeToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDismissInterstitial) name:NotificationDidDismissInterstitial object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interstitialDidFail) name:NotificationInterstitalDidFail object:nil];
}

- (void)start {
    [LWFSoundPlayer stopMusic];
    [LWFSoundPlayer play:LWFSoundTypeGameOver];
    
    [self stopUserInteractions];
    [self addBlackOverlay];
    [self removeHUDElements];
    [self addGameOverTitle];
    [self triggerTimedAd];
}

- (void)displayAfterAd {
    [self displayStats];
    [self displayActions];
}

- (void)stopUserInteractions {
    LWFGameController *gameController = [self getGameController];
    LWFMap *map = gameController.map;
    [map blockUserInteraction];
}

- (void)addBlackOverlay {
    LWFGameController *gameController = [self getGameController];
    
    LWFMap *map = [gameController map];
    
    for (NSArray *tiles in map.tileMap.tiles) {
        for (LWFTile *tile in tiles) {
            [tile runAction:[SKAction colorizeWithColor:[SKColor blackColor] colorBlendFactor:0.5 duration:0.6]];
        }
    }
}

- (LWFGameController *)getGameController {
    return [LWFGameController sharedGameController];
}

- (void)removeHUDElements {
    LWFInventory *inventory = [LWFInventory sharedInventory];
    
    [self animateRemovalOfUIElements];

    [inventory hideItemDescriptionIfNeeded];
    [inventory hide];
}

- (void)animateRemovalOfUIElements {
    LWFGameController *gameController = [self getGameController];
    LWFViewController *rootController = gameController.rootController;
    LWFHudLifebar *hudLifebar = [LWFHudLifebar sharedHudLifeBar];
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(1.0);
    anim.toValue = @(0.0);
    anim.duration = 2.0;
    
    NSArray *viewsToAnimate = @[rootController.viewSpecialAttackButton,
                                rootController.viewInventoryButton,
                                rootController.viewLogContainer,
                                hudLifebar.containerView];
    
    for (UIView *view in viewsToAnimate) {
        [view pop_addAnimation:anim forKey:@"fade"];
    }
    
    [rootController updatePieView:0 forTotalTurns:0];
}

- (void)animateAditionOfUIElements {    
    LWFGameController *gameController = [self getGameController];
    LWFViewController *rootController = gameController.rootController;
    LWFHudLifebar *hudLifebar = [LWFHudLifebar sharedHudLifeBar];
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    anim.duration = 2.0;
    
    NSArray *viewsToAnimate = @[rootController.viewSpecialAttackButton,
                                rootController.viewInventoryButton,
                                rootController.viewLogContainer,
                                hudLifebar.containerView];
    
    for (UIView *view in viewsToAnimate) {
        [view pop_addAnimation:anim forKey:@"fade"];
    }
}

- (void)addGameOverTitle {
    LWFGameController *gameController = [self getGameController];
    
    if (_title == nil) {
        _title = [LWFGameOverTitle new];
        LWFViewController *viewController = gameController.rootController;
        
        [_title addToView:viewController.view];
    }
}

- (void)triggerTimedAd {
    _adErrorTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(adTimeout) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(displayAd)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)adTimeout {
    [self displayAfterAd];
}

- (void)displayAd {
    [Chartboost showInterstitial:CBLocationHomeScreen];
}

- (void)didDismissInterstitial {
    [self displayAfterAd];
}

- (void)interstitialDidFail {
    [self displayAfterAd];
}

- (void)displayStats {
    if (_gameOverStats == nil) {
        _gameOverStats = [[LWFGameOverStats alloc]init];
        [_gameOverStats addBelowView:_title.containerView];
    }
    
    NSInteger goldCount = [self getGoldCount];
    NSInteger floorCount = [self getFloorCount];
    
    _gameOverStats.labelGold.text = [NSString stringWithFormat:@"Gold: %d", goldCount];
    _gameOverStats.labelFloor.text = [NSString stringWithFormat:@"Floor: %d", floorCount];
}

- (NSInteger)getGoldCount {
    LWFInventory *inventory = [LWFInventory sharedInventory];
    
    return [inventory money];
}

- (NSInteger)getFloorCount {
    LWFMap *map = [[self getGameController]map];
    
    return map.floor;
}

- (void)displayActions {
    [_adErrorTimer invalidate];
    
    if (_gameOverButtons == nil) {
        _gameOverButtons = [[LWFGameOverButtons alloc]init];
        _gameOverButtons.delegate = self;
        
        [_gameOverButtons addBelowView:_gameOverStats.containerView];
    }
}

- (void)resetGame {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    
    [player.stats reloadStats];
    player.stats.currentHP = player.stats.maxHP;
    [player statsChanged];
    
    [player.oteQueue removeAll];
    [player.inventory clear];
    
    LWFPotionFactory *potionFactory = [LWFPotionFactory sharedPotionFactory];
    [potionFactory resetPotionKnowledgeAndTextures];
}

- (void)showHudElements {
    [self animateAditionOfUIElements];
}

#pragma mark - Actions

- (void)didClickSkillTree {
    [self showSkillTree];
}

- (void)didClickMainMenu {
    
}

- (void)restart {
    [self resetGame];
    
    [_title.containerView removeFromSuperview];
    [_gameOverStats.containerView removeFromSuperview];
    [_gameOverButtons.containerView removeFromSuperview];
    
    _title = nil;
    _gameOverButtons = nil;
    _gameOverStats = nil;
    
    [LWFLogger cleanLog];
    
    [self showHudElements];
    
    [LWFSoundPlayer playMusic:LWFMusicTypeGame];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notificationRestartGame" object:nil];
}
- (void)showSkillTree {
    LWFGameController *gameController = [self getGameController];
    LWFViewController *rootController = gameController.rootController;
    
    LWFSkillTreeController *skillTreeController = [[LWFSkillTreeController alloc] init];
    
    [rootController presentViewController:skillTreeController animated:true completion:nil];

}
- (void)share {
    
}
@end
