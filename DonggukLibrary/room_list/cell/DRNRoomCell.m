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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:15.0f];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor lightGrayColor];
        _statusLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:11.0f];
        
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_statusLabel];
        [self.contentView addSubview:_separator];
        
        [self makeAutoLayoutConstraints];
    }
    return self;
}

#pragma mark - Layout

- (void)makeAutoLayoutConstraints
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@19.0f);
        make.right.equalTo(@(-19.0f));
        make.centerY.equalTo(@(-5.0f));
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@19.0f);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(4.0f);
    }];
    
    [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@.0f);
        make.height.equalTo(@.5f);
        make.left.equalTo(@19.0f);
        make.right.equalTo(@(-19.0f));
    }];
}

#pragma mark - Setter

- (void)setRoom:(DRNRoom *)room
{
    _room = room;
    _titleLabel.text = _room.title;
    NSString *statusText = [NSString stringWithFormat:@"%ld 좌석 중 %ld 좌석 사용중", room.totalCountInteger, room.usingCountInteger];
    _statusLabel.text = statusText;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        _titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:15.0f];
    } else {
        _titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:15.0f];
    }
}

@end
