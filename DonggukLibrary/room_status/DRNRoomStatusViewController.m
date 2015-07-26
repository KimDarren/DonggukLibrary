//
//  DRNRoomStatusViewController.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 10..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNRoomStatusViewController.h"

// Model
#import "DRNRoom.h"
#import "DRNSeat.h"

// View
#import "DRNSeatLabel.h"
#import "DRNTooltipView.h"
#import "DRNRoomStatusTitleView.h"

// Utility
#import "DRNUtility.h"
#import "DRNNetwork.h"

// Library
#import <Masonry/Masonry.h>

@interface DRNRoomStatusViewController () <DRNRoomStatusTitleViewDelegate>

@property (strong, nonatomic) NSArray *enable;
@property (strong, nonatomic) NSArray *disable;
@property (strong, nonatomic) NSArray *using;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) DRNRoomStatusTitleView *titleView;

@end

@implementation DRNRoomStatusViewController

- (instancetype)initWithRoom:(DRNRoom *)room
{
    self = [super init];
    if (self) {
        self.title = room.title;
        
        _room = room;
        
        _titleView = [[DRNRoomStatusTitleView alloc] initWithTitle:_room.title];
        _titleView.delegate = self;
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentInset = UIEdgeInsetsMake(50, 50, 50, 50);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = .5f;
        _scrollView.maximumZoomScale = 1.0f;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped:)];
        tapRecognizer.numberOfTapsRequired = 2;
        tapRecognizer.numberOfTouchesRequired = 1;
        [_scrollView addGestureRecognizer:tapRecognizer];
        
        _tooltipView = [[DRNTooltipView alloc] init];
    }
    return self;
}

#pragma mark - Layout

- (void)makeAutoLayoutConstraints
{
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(@.0f);
        make.height.equalTo(@([DRNUtility statusBarHeight] + DRNRoomStatusTitleContainerHeight));
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.left.right.and.bottom.equalTo(@.0f);
    }];
    
    [_tooltipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(@.0f);
        make.height.equalTo(@44.0f);
    }];
}

- (void)updateViewConstraints
{
    [_titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([DRNUtility statusBarHeight] + DRNRoomStatusTitleContainerHeight));
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
    [self.view addSubview:_titleView];
    [self.view addSubview:_scrollView];
    [self.view addSubview:_tooltipView];
    
    [self makeAutoLayoutConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [DRNNetwork getRoomStatusWithRoom:_room success:^(NSDictionary *responseObject) {
        _enable = [responseObject objectForKey:@"enable"];
        _disable = [responseObject objectForKey:@"disable"];
        _using = [responseObject objectForKey:@"using"];
        
        [self parse];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Data

- (void)parse
{
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"map"
                                              withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:filePath];
    NSError *error;
    
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:&error];
    if (error) {
        NSLog(@"JSONObjectWithData error: %@", error);
    } else {
        NSArray *mapArray = [[array objectAtIndex:_room.numberInteger-1] objectForKey:@"map"];
        mapArray = [DRNSeat seatsWithMapArray:mapArray];
        
        CGFloat maxWidth = 0, maxHeight = 0;
        _containerView = [[UIView alloc] init];
        for (DRNSeat *seat in mapArray) {
            DRNSeatLabel *label = [[DRNSeatLabel alloc] initWithSeat:seat];
            maxWidth    = MAX(maxWidth, label.right);
            maxHeight   = MAX(maxHeight, label.bottom);
            
            if ([_enable containsObject:seat.number]) {
                label.type = DRNSeatLabelTypeEnable;
            } else if ([_disable containsObject:seat.number]) {
                label.type = DRNSeatLabelTypeDisbale;
            } else if ([_using containsObject:seat.number]) {
                label.type = DRNSeatLabelTypeUsing;
            }
            
            [_containerView addSubview:label];
        }
        [_scrollView addSubview:_containerView];
        _containerView.frame = CGRectMake(0, 0, maxWidth, maxHeight);
        _scrollView.contentSize = CGSizeMake(maxWidth, maxHeight);
    }
    [_tooltipView hideWithAnimate:YES];
}

#pragma mark - Actions

- (void)doubleTapped:(UITapGestureRecognizer *)recognizer
{
    if (_scrollView.zoomScale != 1.0f) {
        [_scrollView setZoomScale:1.f animated:YES];
    } else {
        [_scrollView setZoomScale:.5f animated:YES];
    }
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [_tooltipView hideWithAnimate:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_tooltipView hideWithAnimate:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_tooltipView showWithAnimate:YES];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    _containerView.transform = CGAffineTransformMakeScale(scrollView.zoomScale, scrollView.zoomScale);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _containerView;
}

#pragma mark - Room status title view delegate

- (void)roomStatusTitleViewDidSelectCloseButton:(DRNRoomStatusTitleView *)titleView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end