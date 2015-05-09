//
//  DRNNetwork.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNNetwork.h"

// Models
#import "DRNRoom.h"

// Library
#import <AFNetworking/AFNetworking.h>

@implementation DRNNetwork

+ (AFHTTPRequestOperationManager *)requestManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return manager;
}

+ (void)getRoomListWithSuccess:(DRNNetworkSuccessArrayHandler)success failure:(DRNNetworkFailureHandler)failure
{
    AFHTTPRequestOperationManager *manager = [self requestManager];
    [manager GET:URL_ROOM_LIST parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSArray *rooms = [DRNRoom roomsWithResponseObject:responseObject];
            success(rooms);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
