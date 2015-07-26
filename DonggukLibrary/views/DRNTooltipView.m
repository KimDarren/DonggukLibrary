//
//  DRNTooltipView.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 6. 7..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNTooltipView.h"

// Utility
#import "UIColor+DRNExtension.h"

// Library
#import <Masonry/Masonry.h>

@implementation DRNTooltipView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:.75f];
        
        _enableLabel = [[UILabel alloc] init];
        _enableLabel.text = @"사용 가능";
        _enableLabel.backgroundColor = [UIColor drn_darkGrayColor];
        _enableLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:10.0f];
        _enableLabel.textColor = [UIColor whiteColor];
        _enableLabel.textAlignment = NSTextAlignmentCenter;
        
        _usingLabel = [[UILabel alloc] init];
        _usingLabel.text = @"사용 중";
        _usingLabel.backgroundColor = [UIColor drn_darkOrangeColor];
        _usingLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:10.0f];
        _usingLabel.textColor = [UIColor whiteColor];
        _usingLabel.textAlignment = NSTextAlignmentCenter;
        
        _disableLabel = [[UILabel alloc] init];
        _disableLabel.text = @"사용 불가";
        _disableLabel.backgroundColor = [UIColor lightGrayColor];
        _disableLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:10.0f];
        _disableLabel.textColor = [UIColor whiteColor];
        _disableLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_enableLabel];
        [self addSubview:_usingLabel];
        [self addSubview:_disableLabel];
        [self makeAutoLayoutConstraints];
    }
    return self;
}

#pragma mark - Layout

- (void)makeAutoLayoutConstraints
{
    [_enableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80.0f);
        make.height.equalTo(@20.0f);
        make.centerY.equalTo(self);
        make.right.equalTo(_usingLabel.mas_left).with.offset(-20.0f);
    }];
    
    [_usingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80.0f);
        make.height.equalTo(@20.0f);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [_disableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80.0f);
        make.height.equalTo(@20.0f);
        make.centerY.equalTo(self);
        make.left.equalTo(_usingLabel.mas_right).with.offset(20.0f);
    }];
}

#pragma mark -

- (void)hideWithAnimate:(BOOL)animate
{
    if (animate) {
        [UIView animateWithDuration:.3f animations:^{
            self.alpha = .0f;
        }];
    } else {
        self.alpha = .0f;
    }
}

- (void)showWithAnimate:(BOOL)animate
{
    if (animate) {
        [UIView animateWithDuration:.3f animations:^{
            self.alpha = 1.0f;
        }];
    } else {
        self.alpha = 1.0f;
    }
}

@end