//
//  DRNRoom.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRNRoom : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSNumber *totalCount;
@property (strong, nonatomic) NSNumber *usingCount;
@property (strong, nonatomic) NSNumber *remainCount;

@property (nonatomic, readonly) NSInteger numberInteger;
@property (nonatomic, readonly) NSInteger totalCountInteger;
@property (nonatomic, readonly) NSInteger usingCountInteger;
@property (nonatomic, readonly) NSInteger remainCountInteger;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)roomsWithResponseObject:(NSArray *)responseObject;

@end