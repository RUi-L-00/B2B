//
//  OrderFooterView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/29.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderFooterView.h"

@interface OrderFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@end

@implementation OrderFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapAction];
    ViewBorderRadius(self.leftButton, 5, 1, [UIColor colorWithHexString:@"#F16A30"]);
}

-(void)tapAction{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTap:)]){
        [self.delegate didTap:self.index];
    }
}

-(void)setFooterData:(OrderModel *)footerData{
    _footerData = footerData;
    NSInteger num = 0;
    for (GoodModel *good in footerData.goods) {
        num += good.buyCount;
    }
//    self.number.text = [NSString stringWithFormat:@"共%ld件商品 合计：", num];
     self.number.text = [NSString stringWithFormat:@"共2件商品"];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",self.footerData.totalPay.doubleValue];
    [self updateBottomButtons:self.footerData.state];
}

-(void)updateBottomButtons:(JMOrderState)state{
    //更新底部按钮
    //注意顺序，从右到左
    //订单列表
    NSMutableArray *buttonsArray = [[NSMutableArray alloc] init];
    switch (state) {
        case JMOrderState_WaitPay:
            [buttonsArray addObject:@"付款"];
            [buttonsArray addObject:@"删除订单"];
            break;
        case JMOrderState_WaitShenHe:
            [buttonsArray addObject:@"查看凭证"];
            break;
        case JMOrderState_WaitFaHuo:
            for (GoodModel *good in self.footerData.goods) {
                if (good.aftersaleState == JMGoodState_Normal || good.aftersaleState == JMGoodState_CloseAfterSale) {
                    [buttonsArray addObject:@"申请退款"];
                    break;
                }
            }
            break;
        case JMOrderState_ShenHeFail:
            [buttonsArray addObject:@"重新上传"];
            [buttonsArray addObject:@"查看凭证"];
            break;
        case JMOrderState_TuiKuanSuccess:
        case JMOrderState_Close:
            [buttonsArray addObject:@"删除订单"];
            break;
        case JMOrderState_WaitShouHuo:
            [buttonsArray addObject:@"确认收货"];
            for (GoodModel *good in self.footerData.goods) {
                if (good.aftersaleState == JMGoodState_Normal || good.aftersaleState == JMGoodState_CloseAfterSale) {
                    [buttonsArray addObject:@"申请退款"];
                    break;
                }
            }
            break;
        case JMOrderState_Complete:
        case JMOrderState_WaitEvaluate:
            [buttonsArray addObject:@"删除订单"];
            [buttonsArray addObject:@"申请售后"];
            break;
            
        default:
            break;
    }
    switch (buttonsArray.count) {
        case 0:
            self.buttonsView.hidden = YES;
            break;
        case 1:
            self.buttonsView.hidden = NO;
            self.leftButton.hidden = YES;
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:buttonsArray.firstObject forState:UIControlStateNormal];
            break;
        case 2:
            self.buttonsView.hidden = NO;
            self.leftButton.hidden = NO;
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:buttonsArray.firstObject forState:UIControlStateNormal];
            [self.leftButton setTitle:buttonsArray.lastObject forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)action:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *text = button.currentTitle;
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOperationButton:title:)]){
        [self.delegate clickOperationButton:self.index title:text];
    }
}

@end
