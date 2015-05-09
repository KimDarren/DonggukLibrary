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
        self.view.backgroundColor = [UIColor redColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 100.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [_tableView registerClass:[DRNRoomCell class] forCellReuseIdentifier:DRNRoomCellIdentifier];
        [self.view addSubview:_tableView];
        [self makeAutoLayoutConstraints];
    }
    return self;
}

- (void)makeAutoLayoutConstraints
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DRNNetwork getRoomListWithSuccess:^(NSArray *responseObject) {
        _rooms = responseObject;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view delegate and data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRNRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:DRNRoomCellIdentifier
                                                        forIndexPath:indexPath];
    DRNRoom *room = [_rooms objectAtIndex:indexPath.row];
    cell.room = room;
    
    return cell;
}

@end