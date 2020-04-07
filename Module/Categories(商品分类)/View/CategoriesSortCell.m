//
//  CategoriesSortCell.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "CategoriesSortCell.h"

@interface CategoriesSortCell()

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation CategoriesSortCell

- (void)setCellData:(CategoriesModel *)cellData {
    _cellData = cellData;
    self.typeLabel.text = cellData.categoriesName;
    if (cellData.isSelect) {
        self.selectView.hidden = NO;
        self.typeLabel.textColor = [UIColor colorWithHexString:@"#F16A30"];
    } else {
        self.selectView.hidden = YES;
        self.typeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
}

@end
