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
#import <Chartboost/Chartboost.h>

@implementation LWFGameOver

SINGLETON_FOR_CLASS(GameOver)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDismissInterstitial) name:NotificationDidDismissInterstitial object:nil];
    }
    return self;
}

- (void)start {
    
    [self stopUserInteractions];
    [self addBlackOverlay];
    [self removeHUDElements];
    [self addGameOverTitle];
    [self displayAd];
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
    
    LWFGameOverTitle *title = [LWFGameOverTitle new];
    LWFViewController *viewController = gameController.rootController;
    
    [title addToView:viewController.view];

}

- (void)displayAd {
    [Chartboost showInterstitial:CBLocationHomeScreen];
}

- (void)displayActions {
    
}

- (void)requestRestartGame {
    
}

- (void)didDismissInterstitial {
    [self displayActions];
}

#pragma mark - Actions
- (void)didClickRetry {
    
}

- (void)didClickSkillTree {
    
}

- (void)didClickMainMenu {
    
}
@end
