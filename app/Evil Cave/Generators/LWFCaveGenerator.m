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
        _roomBuilder = [[LWFRoomBuilder alloc]initWithMinWidth:3 maxWidth:10 minHeigth:3 andMaxHeigth:10];
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
    
    return _grid;
}

- (void)generateRooms {
    for (NSUInteger i = 0; i < 20; i++) {
        LWFRoom *room = [_roomBuilder build];
        [_rooms addObject:room];
    }
}




@end
