//
//  OrderHeaderView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/29.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderHeaderView.h"

@interface OrderHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end


@implementation OrderHeaderView
-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapAction];
}

-(void)tapAction{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTap:)]){
        [self.delegate didTap:self.index];
    }
}

-(void)setHeaderData:(OrderModel *)headerData{
    _headerData = headerData;
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",self.headerData.orderNo];
    self.statusLabel.text = [self stateTipWithState:self.headerData.state];
}

-(NSString *)stateTipWithState:(JMOrderState)state{
    //订单列表
    NSString *stateTip = @"";
    switch (state) {
        case JMOrderState_WaitPay:
            stateTip = @"待付款";
            break;
        case JMOrderState_WaitShenHe:
            stateTip = @"待审核";
            break;
        case JMOrderState_WaitFaHuo:
            stateTip = @"待发货";
            break;
        case JMOrderState_ShenHeFail:
            stateTip = @"审核不通过";
            break;
        case JMOrderState_TuiKuan:
            stateTip = @"售后中";
            break;
        case JMOrderState_WaitShouHuo:
            stateTip = @"待收货";
            break;
        case JMOrderState_Complete:
        case JMOrderState_WaitEvaluate:
            stateTip = @"已完成";
            break;
        case JMOrderState_TuiKuanSuccess:
        case JMOrderState_CloseAfterSale:
        case JMOrderState_Close:
            stateTip = @"交易关闭";
            break;
        default:
            break;
    }
    return stateTip;
}

@end
