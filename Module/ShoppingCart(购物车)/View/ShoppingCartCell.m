//
//  ShoppingCartCell.m
//  JMBaseProject
//
//  Created by ios on 2019/10/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShoppingCartCell.h"

#import "GoodModel.h"

@interface ShoppingCartCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *lessButton;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.numTextField addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingDidEnd];
//    self.numTextField.delegate = self;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    self.selectButton.selected = isSelect;
}

- (void)setCellData:(GoodModel *)cellData {
    _cellData = cellData;
    if (kUseTestData) {
        self.goodImage.image = [UIImage imageNamed:cellData.coverImage];
        self.specLabel.text = @"96# 豆沙红色";
        self.numTextField.text = @"3";
    } else {
        [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[JMCommonMethod pinImagePath:cellData.coverImage]]];
        self.specLabel.text = cellData.selectSpec.selectSpecCode;
        self.numTextField.text = [NSString stringWithFormat:@"%ld", cellData.buyCount];
    }
    self.nameLabel.text = cellData.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", cellData.price];
    self.selectButton.selected = cellData.isSelect;
}

#pragma mark -private
- (void)textFieldChange {
    //文本框内容变化时执行
    if (self.numTextField.text.integerValue < 1) {
        self.numTextField.text = @"1";
//        self.lessButton.enabled = NO;
        [JMProgressHelper toastInWindowWithMessage:@"不能再减了"];
    } else {
        self.lessButton.enabled = YES;
    }
    self.cellData.buyCount = self.numTextField.text.integerValue;
    //取消延迟执行
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayedExecution) object:nil];
//    //开始新的延迟执行
//    [self performSelector:@selector(delayedExecution) withObject:nil afterDelay:0.5];
}

- (void)delayedExecution {
    //延迟执行block
    self.editBlock(self.cellData);
}

#pragma mark -Actions
- (IBAction)selectAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (self.selectBlock) {
        self.cellData.isSelect = button.selected;
        self.selectBlock(button.selected);
    }
}

- (IBAction)lessAction:(id)sender {
    //---
    self.numTextField.text = [NSString stringWithFormat:@"%ld", self.numTextField.text.integerValue - 1];
    [self textFieldChange];
}

- (IBAction)addAction:(id)sender {
    //+++
    self.numTextField.text = [NSString stringWithFormat:@"%ld", self.numTextField.text.integerValue + 1];
    [self textFieldChange];
}

- (IBAction)pushAction:(id)sender {
    if (self.pushBlock) {
        self.pushBlock();
    }
}

- (IBAction)modifySpecAction:(id)sender {
    if (self.modifySpecBlock) {
        self.modifySpecBlock();
    }
}

@end
