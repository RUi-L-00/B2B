//
//  OrderListVC.h
//  JMBaseProject
//
//  Created by ios on 2019/11/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    JMOrderType_All = -1,    //全部
    JMOrderType_WaitPay = 0,    //待支付
    JMOrderType_WaitShenHe = 1, //待审核
    JMOrderType_WaitFaHuo = 2,  //待发货
    JMOrderType_WaitShouHuo = 7,//待收货
}JMOrderType;

@interface OrderListVC : JMBaseViewController

@property(nonatomic, assign) JMOrderType type;

@end

NS_ASSUME_NONNULL_END
