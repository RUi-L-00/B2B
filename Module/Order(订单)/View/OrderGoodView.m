//
//  OrderGoodView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/10/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderGoodView.h"

@interface OrderGoodView ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterSaleTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation OrderGoodView

-(instancetype)initWithXib{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    self = nibView.firstObject;
    if(self){
        
        
    }
    return self;
}

-(void)setGood:(GoodModel *)good{
    _good = good;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.good.coverImage]];
    self.nameLabel.text = self.good.name;
    self.specLabel.text = self.good.selectSpec.selectSpecCode;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.good.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"x%d",(int)self.good.buyCount];
    //TODO售后中判断
    switch (good.aftersaleState) {
        case JMGoodState_TuiKuan:
        case JMGoodState_TuiHuoTuiKuan:
            self.afterSaleTipLabel.hidden = NO;
            self.afterSaleTipLabel.text = @"售后中";
            break;
        case JMGoodState_AlreadyTuiKuan:
            self.afterSaleTipLabel.hidden = NO;
            self.afterSaleTipLabel.text = @"售后成功";
            break;
        case JMGoodState_TuiKuanSuccess:
            self.afterSaleTipLabel.hidden = NO;
            self.afterSaleTipLabel.text = @"售后失败";
            break;
            
        default:
            self.afterSaleTipLabel.hidden = YES;
            break;
    }
}

- (IBAction)tapAction:(id)sender {
    if(self.tapBlock){
        self.tapBlock(self.good.goodId);
    }
}
@end
