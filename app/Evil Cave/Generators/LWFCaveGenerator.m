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
    
    return generator.stage;
}

- (void)generateStartAndEnd {
    LWFRoom *firstRoom = _rooms.firstObject;
    LWFRoom *fasthestRoom = [self findFarthestRoomOf:firstRoom inArray:_rooms];
    
    _modelGrid.startLevelPosition = firstRoom.midCoordinate;
    _modelGrid.endLevelPosition = fasthestRoom.midCoordinate;
    
    NSInteger startPositionX = _modelGrid.startLevelPosition.x;
    NSInteger startPositionY = _modelGrid.startLevelPosition.y;
    NSInteger endPositionX = _modelGrid.endLevelPosition.x;
    NSInteger endPositionY = _modelGrid.endLevelPosition.y;
    
    _grid[startPositionX][startPositionY] = [[LWFCaveGeneratorCell alloc]initWithX:startPositionX y:startPositionY andType:CaveCellTypeStart];
    
    _grid[endPositionX][endPositionY] = [[LWFCaveGeneratorCell alloc]initWithX:endPositionX y:endPositionY andType:CaveCellTypeEnd];

}

- (void)generateRooms {
    for (NSUInteger i = 0; i < 50; i++) {
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
    LWFRoom *roomStart = [_rooms objectAtIndex:0];
    roomStart.mstVisited = YES;
    
    for (NSUInteger i = 0; i < _rooms.count -1; i++) {
        LWFRoom *nearestRoom = [self findNearestRoomOfRoom:roomStart inArray:_rooms];
        
        [self generatePathBetweenRoom1:roomStart andRoom2:nearestRoom];
        roomStart = nearestRoom;
    }
}

- (LWFRoom *)findNearestRoomOfRoom:(LWFRoom *)originRoom inArray:(NSArray *)availableRooms {
    NSUInteger bestDistance = 9999;
    LWFRoom *bestRoom;
    
    for (LWFRoom *room in availableRooms) {
        if (room.mstVisited == NO) {
            NSUInteger distance = [self distanceBetweenRoom:originRoom andRoom:room];
            if (distance < bestDistance) {
                bestDistance = distance;
                bestRoom = room;
            }
        }
    }
    
    bestRoom.mstVisited = YES;
    return bestRoom;
}

- (LWFRoom *)findFarthestRoomOf:(LWFRoom *)originRoom inArray:(NSArray *)availableRooms {
    NSUInteger bestDistance = 0;
    LWFRoom *bestRoom;
    
    for (LWFRoom *room in availableRooms) {
        NSUInteger distance = [self distanceBetweenRoom:originRoom andRoom:room];
        if (distance > bestDistance) {
            bestDistance = distance;
            bestRoom = room;
        }
    }
    return bestRoom;
}

- (NSUInteger)distanceBetweenRoom:(LWFRoom *)room1 andRoom:(LWFRoom *)room2 {
    NSInteger x = room1.x - room2.x;
    NSInteger y = room1.y - room2.y;
    
    NSInteger distance = (x + y) / 2;
    
    if (distance < 0) {
        return -distance;
    }
    return distance;
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
