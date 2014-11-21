//
//  LWFHumbleBeeFindPath.m
//  Evil Cave
//
//  Created by Leonardo on 11/21/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import "LWFHumbleBeeFindPath.h"

#import "PathFindNode.h"
#import "LWFTile.h"
#import "LWFTileMap.h"
#import "LWFMapDimension.h"

@implementation LWFHumbleBeeFindPath

-(NSArray *)findPath:(int)startX :(int)startY :(int)endX :(int)endY
{
	//find path function. takes a starting point and end point and performs the A-Star algorithm
	//to find a path, if possible. Once a path is found it can be traced by following the last
	//node's parent nodes back to the start
	
	int x,y;
	int newX,newY;
	int currentX,currentY;
	NSMutableArray *openList, *closedList;
	
	if((startX == endX) && (startY == endY))
		return [NSArray array]; //make sure we're not already there
	
	openList = [NSMutableArray array]; //array to hold open nodes
	
	closedList = [NSMutableArray array]; //array to hold closed nodes
	
	PathFindNode *currentNode = nil;
	PathFindNode *aNode = nil;
	
	//create our initial 'starting node', where we begin our search
	PathFindNode *startNode = [PathFindNode node];
	startNode->nodeX = startX;
	startNode->nodeY = startY;
	startNode->parentNode = nil;
	startNode->cost = 0;
	//add it to the open list to be examined
	[openList addObject: startNode];
	
	while([openList count])
	{
		//while there are nodes to be examined...
		
		//get the lowest cost node so far:
		currentNode = [self lowestCostNodeInArray: openList];
		
		if((currentNode->nodeX == endX) && (currentNode->nodeY == endY))
		{
            NSMutableArray *resultPath = [NSMutableArray array];
            while(aNode->parentNode != nil)
			{
                LWFTile *tile = [self.tileMap tileForVertical:aNode->nodeX andHorizontal:aNode->nodeY];
                [resultPath addObject:tile];
                aNode = aNode->parentNode;
			}
            
            // found
			return resultPath;
		}
		else
		{
			//...otherwise, examine this node.
			//remove it from open list, add it to closed:
			[closedList addObject: currentNode];
			[openList removeObject: currentNode];
			
			//lets keep track of our coordinates:
			currentX = currentNode->nodeX;
			currentY = currentNode->nodeY;
			
			//check all the surrounding nodes/tiles:
			for(y=-1;y<=1;y++)
			{
				newY = currentY+y;
				for(x=-1;x<=1;x++)
				{
					newX = currentX+x;
					if(y || x) //avoid 0,0
					{
						//simple bounds check for the demo app's array
						if((newX>=0)&&(newY>=0)&&(newX<self.tileMap.mapDimension.numberTilesHorizontal)&&(newY<self.tileMap.mapDimension.numberTilesVertical))
						{
							//if the node isn't in the open list...
							if(![self nodeInArray: openList withX: newX Y:newY])
							{
								//and its not in the closed list...
								if(![self nodeInArray: closedList withX: newX Y:newY])
								{
									//and the space isn't blocked
									if(![self spaceIsBlocked: newX :newY])
									{
										//then add it to our open list and figure out
										//the 'cost':
										aNode = [PathFindNode node];
										aNode->nodeX = newX;
										aNode->nodeY = newY;
										aNode->parentNode = currentNode;
										aNode->cost = currentNode->cost + 1;
										
										//Compute your cost here. This demo app uses a simple manhattan
										//distance, added to the existing cost
										aNode->cost += (abs((newX) - endX) + abs((newY) - endY));
										
										[openList addObject: aNode];
										
									}
								}
							}
						}
					}
				}
			}
		}
	}
	//**** NO PATH FOUND *****
    
    NSLog(@"NO PATH FOUND");
    return nil;

}

-(PathFindNode*)lowestCostNodeInArray:(NSMutableArray*)a
{
	//Finds the node in a given array which has the lowest cost
	PathFindNode *n, *lowest;
	lowest = nil;
	NSEnumerator *e = [a objectEnumerator];
	
	while((n = [e nextObject]))
	{
		if(lowest == nil)
		{
			lowest = n;
		}
		else
		{
			if(n->cost < lowest->cost)
			{
				lowest = n;
			}
		}
	}
	return lowest;
}

-(PathFindNode*)nodeInArray:(NSMutableArray*)a withX:(int)x Y:(int)y
{
	//Quickie method to find a given node in the array with a specific x,y value
	NSEnumerator *e = [a objectEnumerator];
	PathFindNode *n;
	
	while((n = [e nextObject]))
	{
		if((n->nodeX == x) && (n->nodeY == y))
		{
			return n;
		}
	}
	
	return nil;
}

-(BOOL)spaceIsBlocked:(int)x :(int)y;
{
    if (x >= self.tileMap.mapDimension.numberTilesHorizontal) {
        return YES;
    }
    
    if (y >= self.tileMap.mapDimension.numberTilesVertical) {
        return YES;
    }
    
    LWFTile *checkingTile = [self.tileMap tileForVertical:x andHorizontal:y];
    
    if (checkingTile == nil) {
        return YES;
    }
    
    return ![checkingTile isPassable];
}


@end
