//
//  DRNRoomStatusTitleView.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 6. 7..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat DRNRoomStatusTitleContainerHeight = 44.0f;

@class DRNRoomStatusTitleView;

@protocol DRNRoomStatusTitleViewDelegate <NSObject>

- (void)roomStatusTitleViewDidSelectCloseButton:(DRNRoomStatusTitleView *)titleView;

@end

@interface DRNRoomStatusTitleView : UIView

@property (weak, nonatomic) id<DRNRoomStatusTitleViewDelegate> delegate;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UIView *separator;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)init;

@end