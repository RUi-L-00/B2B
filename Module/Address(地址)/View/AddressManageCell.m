//
//  AddressManageCell.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressManageCell.h"

@interface AddressManageCell()

@property (weak, nonatomic) IBOutlet UIButton *selectFlagButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation AddressManageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setCellData:(AddressModel *)cellData{
    _cellData = cellData;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",self.cellData.name];
    self.phoneLabel.text = self.cellData.phone;
    self.addressLabel.text = [NSString stringWithFormat:@"%@",[self.cellData allAddress]];
    self.selectFlagButton.selected = self.cellData.isDefault;
}

@end
