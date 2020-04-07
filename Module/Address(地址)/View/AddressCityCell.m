//
//  CityCell.m
//  JMBaseProject
//
//  Created by Liuny on 2018/12/6.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "AddressCityCell.h"

@interface AddressCityCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectFlagImageView;

@end

@implementation AddressCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)updateWithTitle:(NSString *)title isSelect:(BOOL)isSelect{
    self.titleLabel.text = title;
    if(isSelect){
        self.selectFlagImageView.hidden = NO;
        self.titleLabel.textColor = kColorCityTintColor;
    }else{
        self.selectFlagImageView.hidden = YES;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
}

@end
