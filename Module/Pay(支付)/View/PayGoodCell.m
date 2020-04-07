//
//  PayGoodCell.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayGoodCell.h"

@interface PayGoodCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodImage;//商品图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//商品名称
@property (weak, nonatomic) IBOutlet UILabel *normLabel;//商品规格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//商品价格
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//商品数量

@end

@implementation PayGoodCell

- (void)setCellData:(GoodModel *)cellData {
    _cellData = cellData;
//    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:JMImageUrl(cellData.coverImage)]];
    self.nameLabel.text = cellData.name;
    self.normLabel.text = cellData.selectSpec.selectSpecCode;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", cellData.selectSpec.price];
    self.countLabel.text = [NSString stringWithFormat:@"x%ld", cellData.buyCount];
}

@end
