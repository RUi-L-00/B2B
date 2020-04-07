//
//  GoodsDetailsSelectSpecificationAlert.h
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBottomAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum JMSelectSpec : NSInteger {
    JMSelectNorm_Details = 0,           //商品详情
    JMSelectNorm_Car,                   //购物车
}JMSelectSpecType;

@interface GoodsDetailsSelectSpecificationAlert : JMBottomAlertViewController

@property (assign, nonatomic) JMSelectSpecType type;
@property (strong, nonatomic) GoodModel *goodModel;
@property (copy, nonatomic) void(^selectBlock)(NSString *specStr);
@property (copy, nonatomic) void(^buyBlock)(GoodModel *goodModel);

@end

NS_ASSUME_NONNULL_END
