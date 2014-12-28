//
//  LWFDartDungeonGenerator.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 12/28/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFDartDungeonGenerator.h"
#import "LWFCaveGeneratorCell.h"
#import "LWFRandomUtils.h"
#import "LWFRect.h"

@interface LWFDartDungeonGenerator () {
    int numRoomTries;
    
    /// The inverse chance of adding a connector between two regions that have
    /// already been joined. Increasing this leads to more loosely connected
    /// dungeons.
    int extraConnectorChance;
    
    /// Increasing this allows rooms to be larger.
    int roomExtraSize;
    
    int windingPercent;
    
    NSMutableArray *_rooms;
    
    /// For each open position in the dungeon, the index of the connected region
    /// that that position is a part of.
    NSMutableArray *_regions;
    
    /// The index of the current region being carved.
    int _currentRegion;
    
    int _stageWidth;
    int _stageHeight;
    
    
    LWFRandomUtils *_randomizer;
}

@end

@implementation LWFDartDungeonGenerator

- (instancetype)initForStageWidth:(NSInteger)stageWidth andStageHeigth:(NSInteger)stageHeight
{
    self = [super init];
    if (self) {
        _stageHeight = stageHeight;
        _stageWidth = stageWidth;
        
        _randomizer = [[LWFRandomUtils alloc]init];
        
        [self initializeVariables];
    }
    return self;
}

- (void)initializeVariables {
    numRoomTries = 200;
    extraConnectorChance = 20;
    roomExtraSize = 0;
    windingPercent = 0;
    _rooms = [NSMutableArray array];
    _regions = [NSMutableArray arrayWithCapacity:_stageWidth];
    for (int i = 0; i < _stageHeight; i++) {
        _regions[i] = [NSMutableArray arrayWithCapacity:_stageHeight];
        for (int j = 0; j < _stageHeight; j++) {
            _regions[i][j] = [NSNull null];
        }
    }
    _currentRegion = -1;
    
    self.stage = [NSMutableArray arrayWithCapacity:_stageWidth];
    for (int i = 0; i < _stageHeight; i++) {
        self.stage[i] = [NSMutableArray arrayWithCapacity:_stageHeight];
        
    }
    
    
}

- (void)generate {
    if (_stageWidth % 2 == 0 || _stageHeight % 2 == 0) {
        NSLog(@"The stage must be odd-sized.");
        return;
    }
    
    [self fill];
    
    [self addRooms];
    
    NSLog(@"preenchi");
}

- (void)fill {
    for (int x = 0; x < _stageWidth; x++) {
        for (int y = 0; y < _stageHeight; y++) {
            self.stage[x][y] = [LWFCaveGeneratorCell cellForX:x y:y andType:CaveCellTypeWall];
        }
    }
}

- (void)addRooms {
    for (int i = 0; i < numRoomTries; i++) {
        int sizeMax = 3 + roomExtraSize;
        NSInteger size = [_randomizer randomIntegerBetween:1 and:sizeMax];
        size = size * 3 + 1;
        
        int rectangularityMax = 1 + size / 2;
        
        NSInteger rectangularity = [_randomizer randomIntegerBetween:0 and:rectangularityMax] * 2;
        
        int width = size;
        int height = size;
        
        NSInteger bla = [_randomizer randomIntegerBetween:0 and:2];
        
        if (bla) {
            width += rectangularity;
        } else {
            height += rectangularity;
        }
        
        int maxX = ((_stageWidth - width) / 2);
        int x = [_randomizer randomIntegerBetween:0 and:maxX] * 2 + 1;
        
        int maxY = ((_stageHeight - height) / 2);
        int y = [_randomizer randomIntegerBetween:0 and:maxY] * 2 + 1;
        
        LWFRect *room = [LWFRect rectWithX:x y:y width:width andHeight:height];
        
        BOOL overlaps = NO;
        for (LWFRect *other in _rooms) {
            if ([room distanceTo:other] <= 0) {
                overlaps = true;
                break;
            }
        }
        
        if (overlaps) continue;
        
        [_rooms addObject:room];
        
        [self startRegion];
        
        [self carveForRoom:room withType:CaveCellTypeFloor];
        
        
    }
}

- (void)carveForRoom:(LWFRect *)rect withType:(CaveCellType)type {
    for (int x = rect.x; x < rect.x + rect.width; x++) {
        for (int y = rect.y; y < rect.y + rect.height; y++) {
            [self carveX:x y:y type:type];
        }
    }
}

- (void)startRegion {
    _currentRegion++;
}

- (void)carveX:(NSInteger)x y:(NSInteger)y type:(CaveCellType)type {
    _regions[x][y] = [NSNumber numberWithInteger:_currentRegion];
    
    self.stage[x][y] = [LWFCaveGeneratorCell cellForX:x y:y andType:type];
}

@end
