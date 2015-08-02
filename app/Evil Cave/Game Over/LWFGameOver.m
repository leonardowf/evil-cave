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
    LWFGameController *gameController = [self getGameController];
    LWFViewController *rootController = gameController.rootController;
    LWFHudLifebar *hudLifebar = [LWFHudLifebar sharedHudLifeBar];
    
    // TODO: Animações
    
    rootController.viewSpecialAttackButton.hidden = YES;
    rootController.viewInventoryButton.hidden = YES;
    rootController.viewLogContainer.hidden = YES;
    hudLifebar.containerView.hidden = YES;
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
    
    [NSTimer scheduledTimerWithTimeInterval:0.2
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
    _gameOverStats = [[LWFGameOverStats alloc]init];
    
    [_gameOverStats addBelowView:_title.containerView];
}

- (void)displayActions {
    [_adErrorTimer invalidate];
    
    _gameOverButtons = [[LWFGameOverButtons alloc]init];
    _gameOverButtons.delegate = self;
    
    [_gameOverButtons addBelowView:_gameOverStats.containerView];
}

- (void)resetGame {
    LWFPlayer *player = [LWFPlayer sharedPlayer];
    player.stats.currentHP = player.stats.maxHP;
    [player statsChanged];
    
    [player.oteQueue removeAll];
    [player.inventory clear];
}

- (void)showHudElements {
    LWFGameController *gameController = [self getGameController];
    LWFViewController *rootController = gameController.rootController;
    LWFHudLifebar *hudLifebar = [LWFHudLifebar sharedHudLifeBar];
    
    // TODO: Animações
    
    rootController.viewSpecialAttackButton.hidden = NO;
    rootController.viewInventoryButton.hidden = NO;
    rootController.viewLogContainer.hidden = NO;
    hudLifebar.containerView.hidden = NO;
}

#pragma mark - Actions

- (void)didClickSkillTree {
    
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
    _gameOverButtons = nil;
    
    [self showHudElements];
    
    NSLog(@"restartando");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notificationRestartGame" object:nil];
}
- (void)showSkillTree {
    
}
- (void)share {
    
}
@end
