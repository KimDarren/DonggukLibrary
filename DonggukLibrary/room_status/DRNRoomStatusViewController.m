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

// Utility
#import "DRNNetwork.h"

// Library
#import <Masonry/Masonry.h>

@interface DRNRoomStatusViewController ()

@property (strong, nonatomic) NSArray *enable;
@property (strong, nonatomic) NSArray *disable;
@property (strong, nonatomic) NSArray *using;

@end

@implementation DRNRoomStatusViewController

- (instancetype)initWithRoom:(DRNRoom *)room
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        _room = room;
        
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        
        [self makeAutoLayoutConstraints];
    }
    return self;
}

- (void)makeAutoLayoutConstraints
{
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [DRNNetwork getRoomStatusWithRoom:_room success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        
        _enable = [responseObject objectForKey:@"enable"];
        _disable = [responseObject objectForKey:@"disable"];
        _using = [responseObject objectForKey:@"using"];
        [self parse];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

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
        
        CGFloat maxWidth = 0;
        CGFloat maxHeight = 0;
        for (DRNSeat *seat in mapArray) {
            UILabel *label = [[UILabel alloc] init];
            label.text = @([seat.number integerValue]).stringValue;
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(seat.positionXInteger * 43.0f,
                                     seat.positionYInteger * 30.0f,
                                     40.0f,
                                     27.0f);
            if ([_enable containsObject:seat.number]) {
                label.backgroundColor = [UIColor orangeColor];
            }
            maxWidth = MAX(maxWidth, seat.positionXInteger * 43.0f + 40.0f);
            maxHeight = MAX(maxHeight, seat.positionYInteger * 30.0f + 27.0f);
            
            [_scrollView addSubview:label];
        }
        _scrollView.contentSize = CGSizeMake(maxWidth, maxHeight);
    }
}

@end