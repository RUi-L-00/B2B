//
//  NoticeGiftRedemptionCell.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "NoticeGiftRedemptionCell.h"

#import "NoticeModel.h"

@interface NoticeGiftRedemptionCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//消息标题
@property (weak, nonatomic) IBOutlet UIImageView *unreadLogoImage;//未读标识
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间

@end

@implementation NoticeGiftRedemptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(NoticeModel *)cellData {
    _cellData = cellData;
    self.titleLabel.text = cellData.title;
    self.unreadLogoImage.hidden = cellData.isUnread.integerValue == 1;
    self.timeLabel.text = cellData.time;
}

@end
