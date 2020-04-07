//
//  HomeTypeCell.m
//  JMBaseProject
//
//  Created by ios on 2019/10/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "HomeTypeCell.h"

@interface HomeTypeCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HomeTypeCell

- (void)setCellData:(CategoriesModel *)cellData {
    _cellData = cellData;
    self.nameLabel.text = cellData.categoriesName;
    if ([cellData.categoriesId isEqualToString:@"000"]) {
        self.headImage.image = [UIImage imageNamed:cellData.categoriesImage];
    } else {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[JMCommonMethod pinImagePath:cellData.categoriesImage]]];
    }
}

@end
