//
//  CategoriesSecondaryCell.m
//  JMBaseProject
//
//  Created by ios on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "CategoriesSecondaryCell.h"

#import "CategoriesSecondaryModel.h"

@interface CategoriesSecondaryCell()

@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CategoriesSecondaryCell

- (void)setCellData:(CategoriesSecondaryModel *)cellData {
    _cellData = cellData;
    self.nameLabel.text = cellData.categoriesSecondaryName;
    if ([cellData.categoriesSecondaryId isEqualToString:@"000"]) {
        self.categoryImage.image = [UIImage imageNamed:cellData.categoriesSecondaryImage];
    } else {
        [self.categoryImage sd_setImageWithURL:[NSURL URLWithString:[JMCommonMethod pinImagePath:cellData.categoriesSecondaryImage]]];
    }
}

@end
