//
//  LWFPathFinder.m
//  Evil Cave
//
//  Created by Leonardo on 11/19/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFPathFinder.h"

@implementation LWFPathFinder

- (void)findPathFrom:(CGPoint)start to:(CGPoint)end
{
    HSAIPathFinding *pathFinder = [[HSAIPathFinding alloc] init];
    pathFinder.delegate = self;
    pathFinder.heuristic = [HSAIPathFindingHeuristic diagonalHeuristic];
    
    [pathFinder findPathFrom: start to: end]; // returns an array of HSAIPathFindingNodes
}

- (BOOL) nodeIsPassable: (HSAIPathFindingNode *) node
{
    // The logic you use to figure out if a node is passable.
    return YES;
}

- (NSArray *) neighborsFor: (HSAIPathFindingNode *) node
{
    // The logic you use to figure out neighbors
    return [[NSArray alloc] init];
}

@end
