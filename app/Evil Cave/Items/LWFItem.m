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
    NSString *textureName = [NSString stringWithFormat:@"item_%@", prototype.imageName];
    SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
    texture.filteringMode = SKTextureFilteringNearest;
    
    self = [super initWithTexture:texture];
    if (self) {
        [self calculateForKey:@"lowdamage" andPrototype:prototype];
        [self calculateForKey:@"highdamage" andPrototype:prototype];
        [self calculateForKey:@"strength" andPrototype:prototype];
        [self calculateForKey:@"HP" andPrototype:prototype];
        [self calculateForKey:@"armor" andPrototype:prototype];
        
        self.quantity = 1;
        
        self.prototype = prototype;
        
        self.name = prototype.name;
        self.category = prototype.category;
        self.identifier = prototype.identifier;
        self.imageName = prototype.imageName;
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

- (NSString *)damageText {
    if (self.lowdamage != nil && self.highdamage != nil) {
        return [NSString stringWithFormat:@"Damage: %@-%@", [self.lowdamage stringValue], [self.highdamage stringValue]];
    }
    
    return @"";
}

- (NSString *)armorText {
    if (self.armor != nil) {
        return [NSString stringWithFormat:@"Armor: %@", [self.armor stringValue]];
    }
    
    return @"";
}

- (NSString *)strengthText {
    if (self.strength != nil) {
        return [NSString stringWithFormat:@"Strength: %@", [self.strength stringValue]];
    }
    
    return @"";
}

- (NSString *)hpText {
    if (self.HP != nil) {
        return [NSString stringWithFormat:@"HP: %@", [self.HP stringValue]];
    }
    return @"";
}

- (BOOL)isMoney {
    if ([self.category isEqualToString:@"money"]) {
        return YES;
    }
    
    return NO;
}

- (SKLabelNode *)getLabel {
    if ([self isMoney]) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Munro"];
        label.fontSize = 20;
        
        UIColor *labelColor;
        labelColor = [UIColor colorWithRed:1.0 green:215.0/255.0 blue:0.0 alpha:1.0];

        [label setFontColor:labelColor];
        label.text = [NSString stringWithFormat:@"%d", self.quantity];
        
        return label;
        
    }
    return nil;
}


@end
