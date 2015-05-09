//
//  DRNRoomCell.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "DRNRoomCell.h"

// Model
#import "DRNRoom.h"

// Library
#import <Masonry/Masonry.h>

@implementation DRNRoomCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _titleLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:_titleLabel];
    [self makeAutoLayoutConstraints];
}

- (void)makeAutoLayoutConstraints
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@19.0f);
        make.right.equalTo(@(-19.0f));
        make.top.equalTo(@10.0f);
        make.bottom.equalTo(@(-10.0f));
    }];
}

#pragma mark - Setter

- (void)setRoom:(DRNRoom *)room
{
    _room = room;
    _titleLabel.text = _room.title;
}

@end
