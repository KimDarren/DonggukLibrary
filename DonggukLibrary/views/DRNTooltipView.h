//
//  DRNTooltipView.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 6. 7..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRNTooltipView : UIView

@property (strong, nonatomic) UILabel *enableLabel;
@property (strong, nonatomic) UILabel *disableLabel;
@property (strong, nonatomic) UILabel *usingLabel;

- (instancetype)init;

- (void)hideWithAnimate:(BOOL)animate;
- (void)showWithAnimate:(BOOL)animate;

@end