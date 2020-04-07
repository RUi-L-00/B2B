//
//  PayResultVC.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayResultVC : JMBaseViewController

@property (copy, nonatomic) NSString *total;//待支付金额
@property (copy, nonatomic) NSString *orderId;//订单id

@end

NS_ASSUME_NONNULL_END
