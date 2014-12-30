//
//  LWFConstants.h
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 11/30/14.
//  Copyright (c) 2014 leonardowistuba. All rights reserved.
//

#ifndef Evil_Cave_LWFConstants_h
#define Evil_Cave_LWFConstants_h

#define TILE_SIZE 32

#define MAX_NUMBER_PATH_FIND_TRIES 3
// Define a quantidade de vezes que a inteligência artifical tenta se mover até encontrar

#define SINGLETON_FOR_CLASS(classname)\
+ (id) shared##classname {\
static dispatch_once_t pred = 0;\
__strong static id _sharedObject = nil;\
dispatch_once(&pred, ^{\
_sharedObject = [[self alloc] init];\
});\
return _sharedObject;\
}

#endif


