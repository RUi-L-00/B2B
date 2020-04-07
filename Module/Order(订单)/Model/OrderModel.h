//
//  OrderModel.h
//  JMBaseProject
//
//  Created by ios on 2019/12/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressModel;

NS_ASSUME_NONNULL_BEGIN

//订单状态
typedef enum : NSInteger {
    JMOrderState_WaitPay        = 0,        //待付款
    JMOrderState_WaitShenHe     = 1,        //待审核
    JMOrderState_WaitFaHuo      = 2,        //待发货
    JMOrderState_ShenHeFail     = 3,        //审核失败
    JMOrderState_TuiKuan        = 4,        //退款中
    JMOrderState_TuiKuanSuccess = 5,        //退款成功
    JMOrderState_Close          = 6,        //取消订单（交易关闭)
    JMOrderState_WaitShouHuo    = 7,        //已发货,待收货
    JMOrderState_Complete       = 8,        //已完成
    JMOrderState_WaitEvaluate   = 9,        //待评价
    JMOrderState_CloseAfterSale = 10,       //售后关闭
}JMOrderState;

@interface OrderModel : NSObject

@property (nonatomic, assign) JMOrderState state;

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *orderNo;                      //订单号
@property (nonatomic, copy) NSString *afterId;
@property (nonatomic, strong) AddressModel *address;                //收货地址
@property (nonatomic, strong) NSArray<GoodModel *> *goods;
@property (nonatomic, copy) NSString *totalPay;
@property (nonatomic, copy) NSString *mark;                         //留言
@property (nonatomic, copy) NSString *reviewImage;                  //审核图片
@property (nonatomic, copy) NSString *logisticsNo;                  //物流单号
//时间
@property (nonatomic, copy) NSString *createTime;                   //下单时间
@property (nonatomic, copy) NSString *payTime;                      //支付时间
@property (nonatomic, copy) NSString *faHuoTime;                    //发货时间
@property (nonatomic, copy) NSString *evaluateTime;                 //评价时间
@property (nonatomic, copy) NSString *shenHeTime;                   //审核时间
@property (nonatomic, copy) NSString *shenHeReason;                 //审核理由
@property (nonatomic, copy) NSString *completeTime;                 //完成时间
@property (nonatomic, copy) NSString *endTime;                      //关闭时间

-(instancetype)initWithOrderListDictionary:(NSDictionary *)dict;
-(instancetype)initWithDetailDictionary:(NSDictionary *)dict;
-(instancetype)initWithTest;

@end

NS_ASSUME_NONNULL_END
