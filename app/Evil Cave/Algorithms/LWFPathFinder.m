//
//  LWFPathFinder.m
//  Evil Cave
//
//  Created by Leonardo on 11/19/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFPathFinder.h"

#import "LWFTile.h"
#import "LWFTileMap.h"
#import "LWFCreature.h"
#import "LWFMapDimension.h"

@implementation LWFPathFinder

- (void)findPathFrom:(CGPoint)start to:(CGPoint)end
{
    HSAIPathFinding *pathFinder = [[HSAIPathFinding alloc] init];
    pathFinder.delegate = self;
    pathFinder.heuristic = [HSAIPathFindingHeuristic euclidianHeuristic];
    
    NSArray *result = [pathFinder findPathFrom: start to: end]; // returns an array of HSAIPathFindingNodes
    
    NSLog(@"terminou");
}

- (BOOL) nodeIsPassable: (HSAIPathFindingNode *) node
{
    if (node.point.x >= self.tileMap.mapDimension.numberTilesHorizontal) {
        return NO;
    }
    
    if (node.point.y >= self.tileMap.mapDimension.numberTilesVertical) {
        return NO;
    }
    
    LWFTile *checkingTile = [self.tileMap tileForVertical:node.point.x andHorizontal:node.point.y];
    
    if (checkingTile == nil) {
        return NO;
    }
    
    // The logic you use to figure out if a node is passable.
    return [checkingTile isPassable];
}

- (NSArray *) neighborsFor: (HSAIPathFindingNode *) node
{
    LWFTile *checkingTile = [self.tileMap tileForVertical:node.point.x andHorizontal:node.point.y];
    if (checkingTile == nil) {
        return [NSArray array];
    }
    
    
    NSArray *neighbors = [self.tileMap neighborsForTile:checkingTile];
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (LWFTile *tile in neighbors) {
        HSAIPathFindingNode *nNode = [[HSAIPathFindingNode alloc]initWithPosition:CGPointMake(tile.x, tile.y)];
        [result addObject:nNode];
    }
    
    // The logic you use to figure out neighbors
    return result;
}

@end
