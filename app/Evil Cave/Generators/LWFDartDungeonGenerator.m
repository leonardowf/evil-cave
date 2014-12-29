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
#import "LWFPointObject.h"

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

- (NSArray *)directions {
    LWFPointObject *left = [LWFPointObject pointWithX:-1 andY:0];
    LWFPointObject *right = [LWFPointObject pointWithX:1 andY:0];
    LWFPointObject *up = [LWFPointObject pointWithX:0 andY:1];
    LWFPointObject *down = [LWFPointObject pointWithX:0 andY:-1];
    
    return @[left, right, up, down];
}

- (void)generate {
    if (_stageWidth % 2 == 0 || _stageHeight % 2 == 0) {
        NSLog(@"The stage must be odd-sized.");
        return;
    }
    
    [self fill];
    
    [self addRooms];
    
    // Fill in all of the empty space with mazes.
    for (int y = 1; y < _stageHeight; y += 2) {
        for (int x = 1; x < _stageWidth; x += 2) {
            LWFCaveGeneratorCell *cell = _stage[x][y];
            
            if (cell.cellType != CaveCellTypeWall) continue;
            [self growMazeForX:x y:y];
        }
    }
    
    
    NSLog(@"preenchi");
}

- (void)growMazeForX:(NSInteger)x y:(NSUInteger)y {
    NSArray *directions = [self directions];
    
    NSMutableArray *cells = [NSMutableArray array];
    
    LWFPointObject *start = [LWFPointObject pointWithX:x andY:y];
    
    LWFPointObject *lastDir;
    
    [self startRegion];
    
    [self carveX:start.x y:start.y type:CaveCellTypeFloor];
    
    [cells addObject:start];
    
    while ([cells count] > 0) {
        LWFPointObject *cell = [cells lastObject];
        
        // See which adjacent cells are open.
        NSMutableArray *unmadeCells = [NSMutableArray array];
        
        for (LWFPointObject *dir in directions) {
            if ([self canCarve:cell direction:dir]) {
                [unmadeCells addObject:dir];
            }
        }
        
        if ([unmadeCells count] > 0) {
            LWFPointObject *dir;
            
            NSUInteger randomized = [_randomizer randomIntegerBetween:1 and:101];
            
            if ([unmadeCells containsObject:lastDir] && randomized > windingPercent) {
                dir = lastDir;
            } else {
                NSInteger dirIndex = [_randomizer randomIntegerBetween:0 and:unmadeCells.count];
                dir = [unmadeCells objectAtIndex:dirIndex];
            }
            
            int summedX = cell.x + dir.x;
            int summedY = cell.y + dir.y;
            
            int summedXDouble = (dir.x * 2) + cell.x;
            int summedYDouble = (dir.y * 2) + cell.y;
            
            [self carveX:summedX y:summedY type:CaveCellTypeFloor];
            [self carveX:summedXDouble y:summedYDouble type:CaveCellTypeFloor];
            
            LWFPointObject *toAdd = [LWFPointObject pointWithX:summedXDouble andY:summedYDouble];
            [cells addObject:toAdd];
            lastDir = dir;
        } else {
            // No adjacent uncarved cells
            [cells removeLastObject];
            lastDir = nil;
        }
    }
}

- (BOOL)canCarve:(LWFPointObject *)pos direction:(LWFPointObject *)dir {
    int directionX = dir.x * 3;
    int directionY = dir.y * 3;
    
    directionX = directionX + pos.x;
    directionY = directionY + pos.y;
    
    LWFPointObject *newPoint = [LWFPointObject pointWithX:directionX andY:directionY];
    
    if (newPoint.x >= _stageWidth || newPoint.y >= _stageHeight) {
        return false;
    }
    
    if (newPoint.x < 0 || newPoint.y < 0) {
        return false;
    }
    
    int doubleX = dir.x * 2;
    doubleX = doubleX + pos.x;
    
    int doubleY = dir.y * 2;
    doubleY = doubleY + pos.y;
    
    LWFCaveGeneratorCell *cell = self.stage[doubleX][doubleY];
    
    return cell.cellType == CaveCellTypeWall;
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
        size = size * 2 + 1;
        
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
