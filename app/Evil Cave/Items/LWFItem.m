//
//  LWFItem.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 1/2/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFItem.h"
#import "LWFItemPrototype.h"
#import "LWFRandomUtils.h"

@implementation LWFItem

- (instancetype)initWithItemPrototype:(LWFItemPrototype *)prototype
{
    NSString *textureName = [NSString stringWithFormat:@"item_%@", prototype.name];
    SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
    texture.filteringMode = SKTextureFilteringNearest;
    
    self = [super initWithTexture:texture];
    if (self) {
        [self calculateForKey:@"damage" andPrototype:prototype];
        [self calculateForKey:@"strength" andPrototype:prototype];
        [self calculateForKey:@"HP" andPrototype:prototype];
        [self calculateForKey:@"armor" andPrototype:prototype];
        
        self.quantity = 1;
        
        self.prototype = prototype;
        
        self.name = prototype.name;
    }
    
    self.size = CGSizeMake(TILE_SIZE, TILE_SIZE);
    return self;
}

- (void)calculateForKey:(NSString *)key andPrototype:(LWFItemPrototype *)prototype {
    NSString *minKey = [NSString stringWithFormat:@"min%@", [key capitalizedString]];
    NSString *maxKey = [NSString stringWithFormat:@"max%@", [key capitalizedString]];
    NSString *baseKey = [NSString stringWithFormat:@"base%@", [key capitalizedString]];
    
    NSNumber *min = [prototype valueForKey:minKey];
    NSNumber *max = [prototype valueForKey:maxKey];
    NSNumber *base = [prototype valueForKey:baseKey];
    
    if (min != nil && max != nil) {
        LWFRandomUtils *random = [[LWFRandomUtils alloc]init];
        NSNumber *randomized = [random randomNumberBetween:min and:max];
        NSInteger calculatedInteger = [base integerValue] + [randomized integerValue];
        NSNumber *calculatedNumber = [NSNumber numberWithInteger:calculatedInteger];
        [self setValue:calculatedNumber forKey:key];
    } else {
        [self setValue:base forKey:key];
    }
}

@end
