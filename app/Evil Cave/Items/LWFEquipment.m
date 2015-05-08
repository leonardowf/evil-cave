//
//  LWFEquipment.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 5/6/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFEquipment.h"
#import "LWFItemPrototype.h"
#import "LWFRandomUtils.h"

@implementation LWFEquipment

- (BOOL)isEquipment {
    return YES;
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

- (BOOL)isWeapon {
    return [self.category isEqualToString:@"weapon"];
}

- (BOOL)isArmor {
    return [self.category isEqualToString:@"armor"];
}

- (BOOL)isAccessory {
    return [self.category isEqualToString:@"accessory"];
}

- (BOOL)isBoots {
    return [self.category isEqualToString:@"boots"];
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
