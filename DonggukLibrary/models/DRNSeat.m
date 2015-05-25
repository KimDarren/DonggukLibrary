//
//  DRNSeat.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 25..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNSeat.h"

@implementation DRNSeat

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self) {
        _number = [dictionary objectForKey:@"seat_number"];
        _position = [dictionary objectForKey:@"position"];
        _positionX = [_position firstObject];
        _positionY = [_position lastObject];
        
        _numberInteger = [_number integerValue];
        _positionXInteger = [_positionX integerValue];
        _positionYInteger = [_positionY integerValue];
    }
    return self;
}

+ (NSArray *)seatsWithMapArray:(NSArray *)map
{
    NSMutableArray *seats = [NSMutableArray new];
    for (NSDictionary *dictionary in map) {
        DRNSeat *seat = [[DRNSeat alloc] initWithDictionary:dictionary];
        [seats addObject:seat];
    }
    return seats;
}

@end
