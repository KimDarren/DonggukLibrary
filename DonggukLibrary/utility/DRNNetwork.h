//
//  DRNNetwork.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <Foundation/Foundation.h>

#define URL     @"http://api.koreandarren.com/dongguk_library"
#define URL_ROOM_LIST           URL "/room_list.php"
#define URL_ROOM_STATUS(val)    [NSString stringWithFormat:@"%@%@%@", URL, @"/room_status.php?number=", val]

typedef void (^DRNNetworkSuccessHandler) (id responseObject);
typedef void (^DRNNetworkSuccessArrayHandler) (NSArray *responseObject);
typedef void (^DRNNetworkSuccessDictionaryHandler) (NSDictionary *responseObject);
typedef void (^DRNNetworkFailureHandler) (NSError *error);

@class AFHTTPRequestOperationManager;
@class DRNRoom;

@interface DRNNetwork : NSObject

+ (AFHTTPRequestOperationManager *)requestManager;
+ (void)getRoomListWithSuccess:(DRNNetworkSuccessArrayHandler)success failure:(DRNNetworkFailureHandler)failure;

+ (void)getRoomStatusWithRoom:(DRNRoom *)room
                      success:(DRNNetworkSuccessDictionaryHandler)success
                      failure:(DRNNetworkFailureHandler)failure;
+ (void)sendGA:(NSString *)screenName;

@end