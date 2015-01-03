//
//  LWFCaveGenerator.m
//  Evil Cave
//
//  Created by Leonardo on 11/16/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFCaveGenerator.h"
#import "LWFCaveGeneratorCell.h"
#import "LWFRandomUtils.h"
#import "LWFRoomBuilder.h"
#import "LWFRoom.h"

#import "LWFModelGrid.h"

#import "LWFDartDungeonGenerator.h"

#import "LWFRect.h"

@interface LWFCaveGenerator () {
    LWFModelGrid *_modelGrid;
    NSMutableArray *_grid;
    NSUInteger _heigth;
    NSUInteger _width;
    LWFRandomUtils *_randomUtils;
    NSMutableArray *_rooms;
    
    LWFRoomBuilder *_roomBuilder;
}
@end

@implementation LWFCaveGenerator

- (instancetype)initWithHeight:(NSUInteger)heigth width:(NSUInteger)width
{
    self = [super init];
    if (self) {
        _heigth = heigth;
        _width = width;
        _modelGrid = [[LWFModelGrid alloc]init];
        _grid = _modelGrid.model;
        _rooms = _modelGrid.rooms;
        _randomUtils = [[LWFRandomUtils alloc]init];
        _roomBuilder = [[LWFRoomBuilder alloc]initWithMinWidth:3 maxWidth:5 minHeigth:3 andMaxHeigth:5];

        for (NSUInteger i = 0; i < width; i++) {
            _grid[i] = [NSMutableArray arrayWithCapacity:heigth];
            for (NSUInteger j = 0; j < heigth; j++) {
                _grid[i][j] = [[LWFCaveGeneratorCell alloc]initWithX:i y:j andType:CaveCellTypeWall];
            }
        }
    }
    return self;
}

- (NSMutableArray *)generate {
    LWFDartDungeonGenerator *generator = [[LWFDartDungeonGenerator alloc]initForStageWidth:_width andStageHeigth:_heigth];
    
    [generator generate];
    
    [self generateStartAndEndForModelGrid:generator.stage andRooms:generator.rooms];
    
    return generator.stage;
}

- (void)generateStartAndEndForModelGrid:(NSMutableArray *)modelGrid andRooms:(NSMutableArray *)rooms {
    int randomized = [_randomUtils randomIntegerBetween:0 and:rooms.count];
    
    LWFRect *firstRoom = [rooms objectAtIndex:randomized];
    
    CGFloat highest = 0;
    LWFRect *lastRoom = firstRoom;
    
    
    for (LWFRect *testRoom in rooms) {
        CGFloat distance = [testRoom distanceTo:firstRoom];
        
        if (distance > highest) {
            lastRoom = testRoom;
            highest = distance;
        }
    }
    
    CGPoint startCoord = [firstRoom middleCoordinate];
    CGPoint endCoord = [lastRoom middleCoordinate];
    
    int x = startCoord.x;
    int y = startCoord.y;
    
    modelGrid[x][y] = [LWFCaveGeneratorCell cellForX:x y:y andType:CaveCellTypeStart];
    
    x = endCoord.x;
    y = endCoord.y;
    
    modelGrid[x][y] = [LWFCaveGeneratorCell cellForX:x y:y andType:CaveCellTypeEnd];
}

@end
