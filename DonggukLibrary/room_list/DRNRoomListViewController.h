//
//  DRNRoomListViewController.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRNRoomListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *rooms;
@property (strong, nonatomic) UITableView *tableView;

- (instancetype)init;

@end
