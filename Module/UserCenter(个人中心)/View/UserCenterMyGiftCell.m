//
//  UserCenterMyGiftCell.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterMyGiftCell.h"
@interface UserCenterMyGiftCell()
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
@implementation UserCenterMyGiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.shopImageView, 10);
    ViewBorderRadius(self.stateLabel, 2.5, 1, [UIColor colorWithHexString:@"#999999"]);
}

@end
