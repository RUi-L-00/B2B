//
//  OrderGoodView.h
//  JMBaseProject
//
//  Created by Liuny on 2019/10/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderGoodView : UIView

@property (nonatomic, strong) GoodModel *good;
@property (nonatomic, copy) void(^tapBlock)(NSString *goodId);

-(instancetype)initWithXib;

@end

NS_ASSUME_NONNULL_END
