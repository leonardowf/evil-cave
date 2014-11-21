//
//  PathFindNode.h
//  Evil Cave
//
//  Created by Leonardo on 11/21/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathFindNode : NSObject {
@public
	int nodeX,nodeY;
	int cost;
	PathFindNode *parentNode;
}

+(id)node;
@end
