//
//  PaySelectSalesCell.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "PaySelectSalesCell.h"

#import "PaySelectSalesModel.h"

@interface PaySelectSalesCell()

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mailboxLabel;

@end

@implementation PaySelectSalesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(PaySelectSalesModel *)cellData {
    _cellData = cellData;
    self.selectButton.selected = cellData.isSelect;
    self.nameLabel.text = cellData.salesName;
    self.mailboxLabel.text = cellData.mailbox;
}

@end
