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


@interface LWFCaveGenerator () {
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
        _grid = [NSMutableArray arrayWithCapacity:width];
        _randomUtils = [[LWFRandomUtils alloc]init];
        _roomBuilder = [[LWFRoomBuilder alloc]initWithMinWidth:3 maxWidth:5 minHeigth:3 andMaxHeigth:5];
        _rooms = [NSMutableArray array];

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
    [self generateRooms];
    [self addRooms];
    
    [self generateConnectionBetweenRooms];
    
    return _grid;
}

- (void)generateRooms {
    for (NSUInteger i = 0; i < 30; i++) {
        LWFRoom *room = [_roomBuilder build];
        [_rooms addObject:room];
    }
    
}

- (void)addRooms {
    for (LWFRoom *room in _rooms) {
        NSUInteger maxRoomX = _width - room.width;
        NSUInteger maxRoomY = _heigth - room.heigth;
        
        NSUInteger roomPosX = [_randomUtils randomIntegerBetween:0 and:maxRoomX];
        NSUInteger roomPosY = [_randomUtils randomIntegerBetween:0 and:maxRoomY];
        
        room.x = roomPosX;
        room.y = roomPosY;
        
        for (NSUInteger i = room.x; i < room.x + room.width; i++) {
            for (NSUInteger j = room.y; j < room.y + room.heigth; j++) {
                _grid[i][j] = [[LWFCaveGeneratorCell alloc]initWithX:i y:j andType:CaveCellTypeFloor];
            }
        }
        
    }
}

- (void)generateConnectionBetweenRooms {
    for (NSUInteger i = 0; i < _rooms.count -1; i++) {
        LWFRoom *room1 = _rooms[i];
        LWFRoom *room2 = _rooms[i + 1];
        
        [self generatePathBetweenRoom1:room1 andRoom2:room2];
    }
    
}

- (void)generatePathBetweenRoom1:(LWFRoom *)room1 andRoom2:(LWFRoom *)room2 {
    CGPoint midRoom1 = [room1 midCoordinate];
    CGPoint midRoom2 = [room2 midCoordinate];
    
    NSUInteger pathY = midRoom1.y;
    NSUInteger pathX = midRoom1.x;
    NSInteger increment;
    
    // TODO: inverter a geração
    
    if (pathY < midRoom2.y) {
        increment = 1;
    } else {
        increment = -1;
    }
    while (pathY != midRoom2.y) {
        _grid[pathX][pathY] = [[LWFCaveGeneratorCell alloc]initWithX:midRoom1.x y:pathY andType:CaveCellTypeFloor];
        pathY = pathY + increment;
    }
    
    if (pathX < midRoom2.x) {
        increment = 1;
    } else {
        increment = -1;
    }
    
    while (pathX != midRoom2.x) {
        _grid[pathX][pathY] = [[LWFCaveGeneratorCell alloc]initWithX:pathX y:pathY andType:CaveCellTypeFloor];
        pathX = pathX + increment;
    }
    
    
}




@end
