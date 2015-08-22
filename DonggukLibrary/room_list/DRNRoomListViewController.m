//
//  DRNRoomListViewController.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNRoomListViewController.h"

// Model
#import "DRNRoom.h"

// View
#import "DRNRoomCell.h"

// Controller
#import "DRNRoomStatusViewController.h"
#import "DRNAboutViewController.h"

// Utility
#import "DRNNetwork.h"

// Library
#import <Masonry/Masonry.h>

static NSString * const DRNRoomCellIdentifier = @"DRNRoomCell";

@interface DRNRoomListViewController ()

@end

@implementation DRNRoomListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"열람실 목록";
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 100.0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[DRNRoomCell class] forCellReuseIdentifier:DRNRoomCellIdentifier];
    }
    return self;
}

- (void)makeAutoLayoutConstraints
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *aboutItem = [[UIBarButtonItem alloc] initWithTitle:@"?" style:UIBarButtonItemStylePlain target:self action:@selector(presentAboutViewController:)];
    self.navigationItem.leftBarButtonItem = aboutItem;
    
    [self.view addSubview:_tableView];
    [self makeAutoLayoutConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [DRNNetwork getRoomListWithSuccess:^(NSArray *responseObject) {
        _rooms = responseObject;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [DRNNetwork sendGA:@"ROOM LIST"];
}

#pragma mark - Actions

- (void)presentAboutViewController:(id)sender
{
    DRNAboutViewController *aboutViewController = [[DRNAboutViewController alloc] init];
    [self presentViewController:aboutViewController animated:YES completion:nil];
}

#pragma mark - Table view delegate and data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rooms.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRNRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:DRNRoomCellIdentifier
                                                        forIndexPath:indexPath];
    DRNRoom *room = [_rooms objectAtIndex:indexPath.row];
    cell.room = room;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRNRoom *room = [_rooms objectAtIndex:indexPath.row];
    DRNRoomStatusViewController *statusView = [[DRNRoomStatusViewController alloc] initWithRoom:room];
    [self presentViewController:statusView animated:YES completion:nil];
}

@end
