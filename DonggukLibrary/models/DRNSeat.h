//
//  DRNSeat.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 25..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRNSeat : NSObject

@property (strong, nonatomic) NSNumber *number;

@property (strong, nonatomic) NSArray *position;
@property (strong, nonatomic) NSNumber *positionX;
@property (strong, nonatomic) NSNumber *positionY;

@property (nonatomic) NSInteger numberInteger;
@property (nonatomic) NSInteger positionXInteger;
@property (nonatomic) NSInteger positionYInteger;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)seatsWithMapArray:(NSArray *)map;

@end