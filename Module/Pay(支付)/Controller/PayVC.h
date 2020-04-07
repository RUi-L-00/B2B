//
//  PayVC.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

typedef enum : NSInteger {
    JMConfirmOrderType_BuyNow = 0,              //立即购买
    JMConfirmOrderType_BuyCar,                  //购物车
}ConfirmOrderType;

NS_ASSUME_NONNULL_BEGIN

@interface PayVC : JMBaseViewController

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) ConfirmOrderType type;

@end

NS_ASSUME_NONNULL_END
