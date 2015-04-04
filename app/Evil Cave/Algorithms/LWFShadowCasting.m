//
//  LWFShadowCasting.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 2/21/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFShadowCasting.h"
#import "LWFGameController.h"
#import "LWFTileMap.h"
#import "LWFTile.h"

@interface LWFShadowCasting () {
    NSArray *_mult;
}
@end

@implementation LWFShadowCasting

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createMultArray];
    }
    return self;
}



- (void)createMultArray {
    NSArray *c0 = @[@1,  @0,  @0, @-1, @-1,  @0,  @0,  @1];
    NSArray *c1 = @[@0,  @1, @-1,  @0,  @0, @-1,  @1,  @0];
    NSArray *c2 = @[@0,  @1,  @1,  @0,  @0, @-1, @-1,  @0];
    NSArray *c3 = @[@1,  @0,  @0,  @1, @-1,  @0,  @0, @-1];
    
    _mult = [NSArray arrayWithObjects:c0, c1, c2, c3, nil];
}

- (void)doFovStartX:(NSInteger)startX startY:(NSInteger)startY radius:(NSInteger)radius {
    [self lightAtX:startX andY:startY];
    
    NSInteger oct = 0;
    for (oct = 0; oct < 8; oct++) {
        NSInteger m0 = [_mult[0][oct] integerValue];
        NSInteger m1 = [_mult[1][oct] integerValue];
        NSInteger m2 = [_mult[2][oct] integerValue];
        NSInteger m3 = [_mult[3][oct] integerValue];
        
        [self castLight:startX cy:startY row:1 lightStart:1.0 lightEnd:0.0 radius:radius xx:m0 xy:m1 yx:m2 yy:m3 anId:0];
    }
}

- (void)castLight:(NSInteger)cx cy:(NSInteger)cy row:(NSInteger)row
       lightStart:(CGFloat)lightStart lightEnd:(CGFloat)lightEnd
           radius:(NSInteger)radius
               xx:(NSInteger)xx xy:(NSInteger)xy yx:(NSInteger)yx yy:(NSInteger)yy
               anId:(NSInteger)anId {
    
    CGFloat newStart = 0.0; //??
    
    if (lightStart < lightEnd) {
        return;
    }
    
    NSInteger radiusSq = radius * radius;
    
    for (NSInteger j = row; j <= radius; j++) {
        NSInteger dx = -j - 1;
        NSInteger dy = -j;
        BOOL blocked = NO;
        
        while (dx <= 0) {
            dx += 1;
            
            NSInteger mx = cx + dx * xx + dy * xy;
            NSInteger my = cy + dx * yx + dy * yy;
            
            CGFloat lSlope = (dx-0.5)/(dy+0.5);
            CGFloat rSlope = (dx+0.5)/(dy-0.5);
            
            if (lightStart < rSlope) {
                continue;
            } else if (lightEnd > lSlope) {
                break;
            } else {
                if ((dx*dx + dy*dy) < radiusSq) {
                    [self lightAtX:mx andY:my];
                }
                
                if (blocked) {
                    if ([self isBlockedX:mx andY:my]) {
                        newStart = rSlope;
                        continue;
                    } else {
                        blocked = false;
                        lightStart = newStart;
                    }
                } else {
                    if ([self isBlockedX:mx andY:my] && j < radius) {
                        blocked = true;
                        [self castLight:cx cy:cy row:j+1 lightStart:lightStart lightEnd:lSlope radius:radius xx:xx xy:xy yx:yx yy:yy anId:anId+1];
                        newStart = rSlope;
                    }
                }
            }
            
        }
        if (blocked) {
            break;
        }
    }
    
    
}

- (BOOL)isBlockedX:(NSInteger)x andY:(NSInteger)y {
    LWFGameController *gameController = [LWFGameController sharedGameController];
    LWFTileMap *tileMap = gameController.tileMap;
    
    LWFTile *tile = [tileMap tileForVertical:y andHorizontal:x];
    
    if (tile.cellType == CaveCellTypeDoor && !tile.doorIsOpen) {
        return YES;
    }
    
    if (tile.cellType == CaveCellTypeWall) {
        return YES;
    }
    
    return NO;
}

- (void)lightAtX:(NSInteger)x andY:(NSInteger)y {
    NSLog(@"Light x: %d and y: %d", x, y);
    
    LWFGameController *gameController = [LWFGameController sharedGameController];
    LWFTileMap *tileMap = gameController.tileMap;
    LWFTile *tile = [tileMap tileForVertical:y andHorizontal:x];
    
    [self lightTile:tile];

}

- (void)lightTile:(LWFTile *)tile {
    SKAction *action = [SKAction fadeAlphaTo:1.0 duration:0.3];
    [tile runAction:action];
}

@end
