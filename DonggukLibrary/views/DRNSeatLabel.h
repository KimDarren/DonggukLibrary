//
//  DRNSeatLabel.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 26..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRNSeat;

typedef NS_ENUM(NSInteger, DRNSeatLabelType) {
    DRNSeatLabelTypeEnable,
    DRNSeatLabelTypeDisbale,
    DRNSeatLabelTypeUsing
};

static const CGFloat DRNSeatLabelDefaultWidth = 40.0f;
static const CGFloat DRNSeatLabelDefaultHeight = 27.0f;
static const CGFloat DRNSeatLabelDefaultGap = 3.0f;

@interface DRNSeatLabel : UILabel

@property (strong, nonatomic) DRNSeat *seat;
@property (nonatomic) DRNSeatLabelType type;

@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, readonly) CGFloat right;

- (instancetype)initWithSeat:(DRNSeat *)seat;

@end