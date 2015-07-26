//
//  DRNRoomListNavigationController.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNRoomListNavigationController.h"

// Utility
#import "UIColor+DRNExtension.h"

@interface DRNRoomListNavigationController ()

@end

@implementation DRNRoomListNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBar.barTintColor = [UIColor drn_darkGrayColor];
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationBar.translucent = NO;
        
        NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                              NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:17.0f]};
        
        self.navigationBar.titleTextAttributes = titleTextAttributes;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
