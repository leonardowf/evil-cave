//
//  LWFLogger.m
//  Evil Cave
//
//  Created by Leonardo Wistuba de França on 4/4/15.
//  Copyright (c) 2015 leonardowistuba. All rights reserved.
//

#import "LWFLogger.h"
#import "LWFCreature.h"
#import "LWFHudLogger.h"
#import "LWFNewItem.h"


@implementation LWFLogger

+ (void)log:(NSString *)message {
    LWFHudLogger *logger = [LWFHudLogger sharedHudLogger];
    [logger log:message];
}

+ (void)logAttackedCreature:(LWFCreature *)creature damage:(NSInteger)damage {
    NSString *message = [NSString stringWithFormat:@"You attacked %@. %ld damage.", creature.name, (long)damage];
    [LWFLogger log:message];
}

+ (void)logAttackedBy:(LWFCreature *)creature damage:(NSInteger)damage {
    NSString *message = [NSString stringWithFormat:@"%@ attacked you. %ld damage.", creature.name, (long)damage];
    [LWFLogger log:message];
}

+ (void)logGold:(NSInteger)quantity {
    NSString *message = [NSString stringWithFormat:@"You picked: %ld gold.", (long)quantity];
    [LWFLogger log:message];
}

+ (void)logPickedItem:(LWFNewItem *)item {
    if (item.name != nil) {
        NSString *message = [NSString stringWithFormat:@"You picked: %@.", item.name];
        [LWFLogger log:message];
    }
}

@end
