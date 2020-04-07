//
//  AddressSelectCell.m
//  JMBaseProject
//
//  Created by ios on 2019/11/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressSelectCell.h"

@interface AddressSelectCell()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation AddressSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewRadius(self.mainView, 5.0);
}

- (void)setCellData:(AddressModel *)cellData {
    _cellData = cellData;
    self.nameLabel.text = cellData.name;
    self.phoneLabel.text = cellData.phone;
    self.addressLabel.text = [cellData allAddress];
}

@end
