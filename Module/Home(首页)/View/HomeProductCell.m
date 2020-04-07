//
//  HomeProductCell.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "HomeProductCell.h"

@interface HomeProductCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;//商品图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//商品名称
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;//商品简介
@property (weak, nonatomic) IBOutlet UIView *categoryInfoView;//分类信息
@property (weak, nonatomic) IBOutlet UILabel *categoryInfoLabel;//分类

@end

@implementation HomeProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.categoryInfoView, 11);
}

- (void)setCellData:(GoodModel *)cellData {
    _cellData = cellData;
    if (kUseTestData) {
        self.headImage.image = [UIImage imageNamed:cellData.coverImage];
    } else {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[JMCommonMethod pinImagePath:cellData.coverImage]]];
    }
    self.nameLabel.text = cellData.name;
    self.summaryLabel.text = cellData.summary;
    self.categoryInfoLabel.text = cellData.sort;
}

@end
