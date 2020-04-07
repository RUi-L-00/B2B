//
//  PhoneNumberAreaCell.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "PhoneNumberAreaCell.h"
@interface PhoneNumberAreaCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end
@implementation PhoneNumberAreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellData:(PhoneNumberAreaModel *)cellData{
    _cellData = cellData;
    self.nameLabel.text = cellData.name;
    self.numberLabel.text = cellData.number;
    if (cellData.isSelect == YES) {
        self.selectButton.hidden = NO;
    }else{
         self.selectButton.hidden = YES;
    }
}
@end
