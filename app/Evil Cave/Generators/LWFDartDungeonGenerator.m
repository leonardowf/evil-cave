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
    NSNumber *_currentRegionNumber;
    
    NSInteger _stageWidth;
    NSInteger _stageHeight;
    
    
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
    extraConnectorChance = 10;
    roomExtraSize = 0;
    windingPercent = 0;
    _rooms = [NSMutableArray array];
    _regions = [NSMutableArray arrayWithCapacity:_stageWidth];
    for (int i = 0; i < _stageWidth; i++) {
        _regions[i] = [NSMutableArray arrayWithCapacity:_stageHeight];
        for (int j = 0; j < _stageHeight; j++) {
            _regions[i][j] = [NSNull null];
        }
    }
    _currentRegion = -1;
    
    self.stage = [NSMutableArray arrayWithCapacity:_stageWidth];
    for (int i = 0; i < _stageWidth; i++) {
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
    
    [self connectRegions];
    
    [self removeDeadEnds];
    
    self.rooms = _rooms;
}

- (void)removeDeadEnds {
    BOOL done = NO;
    
    NSArray *directions = [self directions];
    
    while (!done) {
        done = YES;
        
        NSInteger inflatedX = _stageWidth - 1;
        NSInteger inflatedY = _stageHeight - 1;
        
        for (int x = 1; x < inflatedX; x++) {
            for (int y = 1; y < inflatedY; y++) {
                LWFPointObject *pos = [LWFPointObject pointWithX:x andY:y];
                
                LWFCaveGeneratorCell *tile = self.stage[pos.x][pos.y];
                if (tile.cellType == CaveCellTypeWall) {
                    continue;
                }
                
                int exits = 0;
                
                for (LWFPointObject *dir in directions) {
                    LWFPointObject *posPlusDir = [LWFPointObject point:pos plus:dir];
                    
                    LWFCaveGeneratorCell *checkingTile = self.stage[posPlusDir.x][posPlusDir.y];
                    
                    if (checkingTile.cellType != CaveCellTypeWall) {
                        exits++;
                    }
                    
                }
                
                if (exits != 1) continue;
                
                done = NO;
                
                self.stage[pos.x][pos.y] = [LWFCaveGeneratorCell cellForX:pos.x y:pos.y andType:CaveCellTypeWall];
                
            }
        }
    }
}

- (void)connectRegions {
    NSMutableDictionary *connectorRegions = [NSMutableDictionary dictionary];
    
    NSInteger inflatedX = _stageWidth - 1;
    NSInteger inflatedY = _stageHeight - 1;
    
    NSArray *directions = [self directions];
    
    for (int x = 1; x < inflatedX; x++) {
        for (int y = 1; y < inflatedY; y++) {
            LWFPointObject *pos = [LWFPointObject pointWithX:x andY:y];
            
            LWFCaveGeneratorCell *tile = self.stage[pos.x][pos.y];
            if (tile.cellType != CaveCellTypeWall) continue;
            
            NSMutableSet *regions = [NSMutableSet set];

            for (LWFPointObject *dir in directions) {
                LWFPointObject *posPlusDir = [LWFPointObject point:pos plus:dir];
                
                NSNumber *region = _regions[posPlusDir.x][posPlusDir.y];
                
                if (region != nil && (id)region != [NSNull null]) {
                    [regions addObject:region];
                }
            }
            
            if ([regions count] < 2) continue;
            
            [connectorRegions setObject:regions forKey:[pos toString]];
        }
    }
    
    NSMutableArray *connectors = [NSMutableArray arrayWithArray:[connectorRegions allKeys]];
    
    NSMutableDictionary *merged = [NSMutableDictionary dictionary];
    
    NSMutableSet *openRegions = [NSMutableSet set];
    
    for (int i = 0; i <= _currentRegion; i++) {
        NSNumber *iNumber = [NSNumber numberWithInt:i];
        [merged setObject:iNumber forKey:iNumber];
        [openRegions addObject:iNumber];
    }
    
    while (openRegions.count > 1) {
        
        if (connectors.count == 0) return;
        
        NSInteger randomized = [_randomizer randomIntegerBetween:0 and:connectors.count];
        NSString *connectorString = [connectors objectAtIndex:randomized];
        
        LWFPointObject *connector = [LWFPointObject pointWithString:connectorString];
        
        [self addJunction:connector];
        
        NSMutableSet *regions1 = [connectorRegions objectForKey:[connector toString]];
        NSMutableArray *regions = [NSMutableArray array];
        for (NSNumber *region in regions1) {
            id lol = [merged objectForKey:region];
            [regions addObject:lol];
        }
        
        NSNumber *dest = [regions firstObject];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:regions];
        [temp removeObject:dest];
        NSArray *sources = temp;
        
        for (int i = 0; i <= _currentRegion; i++) {
            if ([self sources:sources containsMerged:merged withInt:i]) {
                NSNumber *iNumber = [NSNumber numberWithInt:i];
                [merged setObject:dest forKey:iNumber];
            }
        }
        
        
        [self openRegions:openRegions removeAll:sources];
        
        NSMutableArray *toRemove = [NSMutableArray array];
        
        for (NSString *posString in connectors) {
            LWFPointObject *pos = [LWFPointObject pointWithString:posString];
            
            if ([pos isItFuckingNear:connector]) {
                [toRemove addObject:pos];
                continue;
            }
            
            NSMutableArray *regions1 = [connectorRegions objectForKey:[pos toString]];
            NSMutableSet *regions = [NSMutableSet set];
            for (NSNumber *region in regions1) {
                id lol = [merged objectForKey:region];
                [regions addObject:lol];
            }
            
            if (regions.count > 1) {
                continue;
            }
            
            NSInteger randomized = [_randomizer randomIntegerBetween:1 and:101];
            
            if (randomized <= extraConnectorChance) {
                [self addJunction:pos];
            }
            
            [toRemove addObject:pos];
        }
        
        [self connectors:connectors removeObjects:toRemove];
    }
}

- (void)connectors:(NSMutableArray *)connectors removeObjects:(NSMutableArray *)toRemove {
    for (LWFPointObject *objectToRemove in toRemove) {
        [connectors removeObject:[objectToRemove toString]];
    }
}

- (void)openRegions:(NSMutableSet *)openRegions removeAll:(NSArray *)sources {
    for (NSNumber *number in sources) {
        [openRegions removeObject:number];
    }
}

- (BOOL)sources:(NSArray *)sources containsMerged:(NSMutableDictionary *)merged withInt:(int)i {
    NSNumber *iNumber = [NSNumber numberWithInt:i];
    NSNumber *target = [merged objectForKey:iNumber];
    
    for (NSNumber *number in sources) {
        if ([number intValue] == [target intValue]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)addJunction:(LWFPointObject *)pos {
    self.stage[pos.x][pos.y] = [LWFCaveGeneratorCell cellForX:pos.x y:pos.y andType:CaveCellTypeDoor];
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
            
            NSInteger summedX = cell.x + dir.x;
            NSInteger summedY = cell.y + dir.y;
            
            NSInteger summedXDouble = (dir.x * 2) + cell.x;
            NSInteger summedYDouble = (dir.y * 2) + cell.y;
            
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
    NSInteger directionX = dir.x * 3;
    NSInteger directionY = dir.y * 3;
    
    directionX = directionX + pos.x;
    directionY = directionY + pos.y;
    
    LWFPointObject *newPoint = [LWFPointObject pointWithX:directionX andY:directionY];
    
    if (newPoint.x >= _stageWidth || newPoint.y >= _stageHeight) {
        return false;
    }
    
    if (newPoint.x < 0 || newPoint.y < 0) {
        return false;
    }
    
    NSInteger doubleX = dir.x * 2;
    doubleX = doubleX + pos.x;
    
    NSInteger doubleY = dir.y * 2;
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
        
        NSInteger rectangularityMax = 1 + size / 2;
        
        NSInteger rectangularity = [_randomizer randomIntegerBetween:0 and:rectangularityMax] * 2;
        
        NSInteger width = size;
        NSInteger height = size;
        
        NSInteger bla = [_randomizer randomIntegerBetween:0 and:2];
        
        if (bla) {
            width += rectangularity;
        } else {
            height += rectangularity;
        }
        
        NSInteger maxX = ((_stageWidth - width) / 2);
        NSInteger x = [_randomizer randomIntegerBetween:0 and:maxX] * 2 + 1;
        
        NSInteger maxY = ((_stageHeight - height) / 2);
        NSInteger y = [_randomizer randomIntegerBetween:0 and:maxY] * 2 + 1;
        
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
    for (NSInteger x = rect.x; x < rect.x + rect.width; x++) {
        for (NSInteger y = rect.y; y < rect.y + rect.height; y++) {
            [self carveX:x y:y type:type];
        }
    }
}

- (void)startRegion {
    _currentRegion++;
    _currentRegionNumber = [NSNumber numberWithInteger:_currentRegion];
}

- (void)carveX:(NSInteger)x y:(NSInteger)y type:(CaveCellType)type {
    _regions[x][y] = _currentRegionNumber;
    
    self.stage[x][y] = [LWFCaveGeneratorCell cellForX:x y:y andType:type];
}

@end
