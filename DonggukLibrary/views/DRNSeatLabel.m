//
//  DRNSeatLabel.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 26..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNSeatLabel.h"

// Model
#import "DRNSeat.h"

@implementation DRNSeatLabel

- (instancetype)initWithSeat:(DRNSeat *)seat
{
    self = [super init];
    if (self) {
        _seat = seat;
        self.text = @([_seat.number integerValue]).stringValue;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor grayColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:10.0f];
        self.frame = CGRectMake(_seat.positionXInteger * (DRNSeatLabelDefaultWidth + DRNSeatLabelDefaultGap),
                                _seat.positionYInteger * (DRNSeatLabelDefaultHeight + DRNSeatLabelDefaultGap),
                                DRNSeatLabelDefaultWidth,
                                DRNSeatLabelDefaultHeight);
    }
    return self;
}

// Setter
- (void)setType:(DRNSeatLabelType)type
{
    _type = type;
    
    if (_type == DRNSeatLabelTypeEnable) {
        self.backgroundColor = [UIColor orangeColor];
    } else if (_type == DRNSeatLabelTypeDisbale) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

// Getter
- (CGFloat)bottom
{
    return _seat.positionYInteger * (DRNSeatLabelDefaultHeight + DRNSeatLabelDefaultGap) + DRNSeatLabelDefaultHeight;
}

- (CGFloat)right
{
    return (_seat.positionXInteger * (DRNSeatLabelDefaultWidth + DRNSeatLabelDefaultGap)) + DRNSeatLabelDefaultWidth;
}

@end
