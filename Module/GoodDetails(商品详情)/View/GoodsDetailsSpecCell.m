//
//  GoodsDetailsSpecCell.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodsDetailsSpecCell.h"

@interface GoodsDetailsSpecCell()

@property (weak, nonatomic) IBOutlet UIButton *nameButton;

@end

@implementation GoodsDetailsSpecCell

- (void)setCellData:(SpecItemModel *)cellData {
    _cellData = cellData;
    [self.nameButton setTitle:cellData.normName forState:UIControlStateNormal];
    self.nameButton.selected = cellData.isSelect;
}

@end
