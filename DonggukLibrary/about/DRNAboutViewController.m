//
//  DRNAboutViewController.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 7. 26..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNAboutViewController.h"

// View
#import "DRNRoomStatusTitleView.h"

// Utility
#import "DRNUtility.h"
#import "DRNNetwork.h"
#import "UIColor+DRNExtension.h"

// Library
#import <Masonry/Masonry.h>
#import <AFNetworking/UIKit+AFNetworking.h>

@interface DRNAboutViewController () <DRNRoomStatusTitleViewDelegate>

@property (strong, nonatomic) DRNRoomStatusTitleView *titleView;

@end

@implementation DRNAboutViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"About";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        _titleView = [[DRNRoomStatusTitleView alloc] initWithTitle:self.title];
        _titleView.delegate = self;
        
        _faceImageView = [[UIImageView alloc] init];
        _faceImageView.clipsToBounds = YES;
        _faceImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_faceImageView setImageWithURL:[NSURL URLWithString:@"http://graph.facebook.com/my.name.is.taejun/picture?width=500&height=500"]];
        
        _faceShadowView = [[UIView alloc] init];
        _faceShadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        _nameLabel.text = @"KIM TAE JUN";
        
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.text = @"korean.darren@gmail.com";
        _emailLabel.textColor = [UIColor colorWithWhite:1.0f alpha:.8f];
        _emailLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"moreCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _contents = @[[NSString stringWithFormat:@"version %@", [DRNUtility versionString]],
                      @"Open source license",
                      @"Developer Website",
                      @"Send email"];
        
        [self.view addSubview:_titleView];
        [self.view addSubview:_faceImageView];
        [self.view addSubview:_faceShadowView];
        [self.view addSubview:_nameLabel];
        [self.view addSubview:_emailLabel];
        [self.view addSubview:_tableView];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"LICENSE" ofType:@""];
        NSString *content = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
        
        _licenseTextView = [[UITextView alloc] init];
        _licenseTextView.backgroundColor = [UIColor clearColor];
        _licenseTextView.text = content;
        _licenseTextView.selectable = NO;
        _licenseTextView.editable = NO;
        _licenseTextView.textColor = [UIColor whiteColor];
        _licenseTextView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f];
        
        _licenseCloseButton = [[UIButton alloc] init];
        _licenseCloseButton.backgroundColor = [UIColor colorWithWhite:1.0f alpha:.5f];
        _licenseCloseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f];
        [_licenseCloseButton setTitle:@"CLOSE" forState:UIControlStateNormal];
        [_licenseCloseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_licenseCloseButton addTarget:self action:@selector(closeLicenseView:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurredView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [_blurredView addSubview:_licenseTextView];
        [_blurredView addSubview:_licenseCloseButton];
        _blurredView.hidden = YES;
        
        [self.view addSubview:_blurredView];
        
        [self makeAutoLayoutConstraints];
    }
    return self;
}

- (void)makeAutoLayoutConstraints
{
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(@.0f);
        make.height.equalTo(@([DRNUtility statusBarHeight] + DRNRoomStatusTitleContainerHeight));
    }];
    
    [_faceShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_faceImageView);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_faceImageView);
    }];
    
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom);
    }];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        [_faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.equalTo(@.0f);
            make.bottom.equalTo(@.0f);
            make.width.equalTo(_faceImageView.mas_height);
        }];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.bottom.equalTo(@.0f);
            make.left.equalTo(_faceImageView.mas_right);
            make.top.equalTo(_faceImageView.mas_top);
        }];
        
        [_blurredView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_tableView);
        }];
        
        [_licenseTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_licenseCloseButton.mas_top);
            make.left.right.and.top.equalTo(_tableView);
        }];
        
        [_licenseCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44.0f);
            make.left.right.and.bottom.equalTo(_tableView);
        }];
        
    } else {
        [_faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.and.right.equalTo(@0.0f);
            make.height.equalTo(_faceImageView.mas_width).multipliedBy(9.0f/16.0f);
        }];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(@.0f);
            make.top.equalTo(_faceImageView.mas_bottom);
        }];
        
        [_blurredView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(@.0f);
            make.top.equalTo(_faceImageView.mas_bottom);
        }];
        
        [_licenseTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.top.equalTo(@.0f);
            make.bottom.equalTo(_licenseCloseButton.mas_top);
        }];
        
        [_licenseCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44.0f);
            make.left.right.and.bottom.equalTo(@.0f);
        }];
    }
}

- (void)orientationDidChange:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        [_faceImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.equalTo(@.0f);
            make.bottom.equalTo(@.0f);
            make.width.equalTo(_faceImageView.mas_height);
        }];
        
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.and.bottom.equalTo(@.0f);
            make.left.equalTo(_faceImageView.mas_right);
            make.top.equalTo(_faceImageView.mas_top);
        }];
        
        [_blurredView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_tableView);
        }];
        
        [_licenseTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_licenseCloseButton.mas_top);
            make.left.right.and.top.equalTo(_tableView);
        }];
        
        [_licenseCloseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44.0f);
            make.left.right.and.bottom.equalTo(_tableView);
        }];
    } else {
        [_faceImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.and.right.equalTo(@0.0f);
            make.height.equalTo(_faceImageView.mas_width).multipliedBy(9.0f/16.0f);
        }];
        
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(@.0f);
            make.top.equalTo(_faceImageView.mas_bottom);
        }];
        
        [_blurredView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(@.0f);
            make.top.equalTo(_faceImageView.mas_bottom);
        }];
        
        [_licenseTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.top.equalTo(@.0f);
            make.bottom.equalTo(_licenseCloseButton.mas_top);
        }];
        
        [_licenseCloseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44.0f);
            make.left.right.and.bottom.equalTo(@.0f);
        }];
    }
    
    [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(@.0f);
        make.height.equalTo(@([DRNUtility statusBarHeight] + DRNRoomStatusTitleContainerHeight));
    }];
}

#pragma mark - Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [DRNNetwork sendGA:@"ABOUT"];
}

#pragma mark - Action

- (void)close:(UIBarButtonItem *)closeButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeLicenseView:(UIButton *)licenseButton
{
    [UIView animateWithDuration:.2f animations:^{
        _blurredView.hidden = YES;
    }];
}

#pragma mark - Title view delegate

- (void)roomStatusTitleViewDidSelectCloseButton:(DRNRoomStatusTitleView *)titleView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate and data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
    NSString *text = _contents[indexPath.row];
    cell.textLabel.text = text.uppercaseString;
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
    }
    else if (indexPath.row == 1) {
        [UIView animateWithDuration:.2f animations:^{
            _blurredView.hidden = NO;
        }];
    }
    else if (indexPath.row == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://koreandarren.com"]];
    }
    else if (indexPath.row == 3) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:korean.darren@gmail.com"]];
    }
}

@end
