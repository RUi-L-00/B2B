//
//  NoticeSystemCell.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "NoticeSystemCell.h"

#import "NoticeModel.h"

@interface NoticeSystemCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//消息标题
@property (weak, nonatomic) IBOutlet UIImageView *unreadLogoImage;//未读标识
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;//消息简介
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间

@end

@implementation NoticeSystemCell

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
    self.timeLabel.text = cellData.time;
    self.introductionLabel.text = cellData.introduction;
    self.unreadLogoImage.hidden = cellData.isUnread.integerValue == 1;
}

@end
