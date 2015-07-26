//
//  DRNAboutViewController.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 7. 26..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRNAboutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIImageView *faceImageView;
@property (strong, nonatomic) UIView *faceShadowView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *emailLabel;

@property (strong, nonatomic) NSArray *contents;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UITextView *licenseTextView;
@property (strong, nonatomic) UIVisualEffectView *blurredView;
@property (strong, nonatomic) UIButton *licenseCloseButton;

- (instancetype)init;

@end
