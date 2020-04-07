//
//  OrderCell.m
//  JMBaseProject
//
//  Created by ios on 2019/12/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;

@end

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    ViewBorderRadius(self.coverImageView, 10, 1, [UIColor colorWithHexString:@"#1F46E3"]);
}

-(void)setCellData:(GoodModel *)cellData{
    _cellData = cellData;
//    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    [self.coverImageView setImage:[UIImage imageNamed:@"home_pic"]];
    self.nameLabel.text = self.cellData.name;
//    self.specLabel.text = cellData.selectSpec.selectSpecCode;
    self.specLabel.text = @"5G，五彩斑斓白";
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.cellData.price.doubleValue];
    self.countLabel.text = [NSString stringWithFormat:@"x%d",(int)self.cellData.buyCount];
}

@end
