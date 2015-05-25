//
//  DRNRoomStatusViewController.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 10..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRNRoom;

@interface DRNRoomStatusViewController : UIViewController

@property (strong, nonatomic) DRNRoom *room;
@property (strong, nonatomic) UIScrollView *scrollView;

- (instancetype)initWithRoom:(DRNRoom *)room;

@end