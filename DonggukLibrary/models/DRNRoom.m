//
//  DRNRoom.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNRoom.h"

@implementation DRNRoom

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _title = [dictionary objectForKey:@"title"];
        _number = [dictionary objectForKey:@"number"];
        _totalCount = [dictionary objectForKey:@"total_count"];
        _remainCount = [dictionary objectForKey:@"remain_count"];
        _usingCount = [dictionary objectForKey:@"using_count"];
    }
    return self;
}

+ (NSArray *)roomsWithResponseObject:(NSArray *)responseObject
{
    NSMutableArray *rooms = [NSMutableArray new];
    
    for (NSDictionary *dictionary in rooms) {
        DRNRoom *room = [[DRNRoom alloc] initWithDictionary:dictionary];
        [rooms addObject:room];
    }
    
    return rooms;
}

#pragma mark - Getter

- (NSInteger)numberInteger
{
    return _number.integerValue;
}

- (NSInteger)usingCountInteger
{
    return _usingCount.integerValue;
}

- (NSInteger)remainCountInteger
{
    return _remainCount.integerValue;
}

- (NSInteger)totalCountInteger
{
    return _totalCount.integerValue;
}

@end
