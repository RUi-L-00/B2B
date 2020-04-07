//
//  PaySelectSalesVC.h
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

@class PaySelectSalesModel;

NS_ASSUME_NONNULL_BEGIN

@interface PaySelectSalesVC : JMBaseViewController

@property (copy, nonatomic) void(^selectBlock)(PaySelectSalesModel *model);

@end

NS_ASSUME_NONNULL_END
