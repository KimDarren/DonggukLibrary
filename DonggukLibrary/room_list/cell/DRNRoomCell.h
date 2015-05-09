//
//  DRNRoomCell.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 5. 9..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRNRoom;
@interface DRNRoomCell : UITableViewCell

@property (weak, nonatomic)     DRNRoom *room;
@property (strong, nonatomic)   UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
