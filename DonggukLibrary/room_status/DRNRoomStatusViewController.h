//
//  DRNRoomStatusViewController.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 10..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRNRoom;
@class DRNTooltipView;

@interface DRNRoomStatusViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) DRNRoom *room;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) DRNTooltipView *tooltipView;

- (instancetype)initWithRoom:(DRNRoom *)room;

@end