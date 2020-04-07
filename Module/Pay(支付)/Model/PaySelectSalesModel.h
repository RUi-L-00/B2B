//
//  PaySelectSalesModel.h
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaySelectSalesModel : NSObject

@property (copy, nonatomic) NSString *salesId;
@property (copy, nonatomic) NSString *salesName;//销售人员名称
@property (copy, nonatomic) NSString *mailbox;//销售人员邮箱
@property (assign, nonatomic) BOOL isSelect;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
//假数据初始化方法
-(instancetype)initWithTest;

@end

NS_ASSUME_NONNULL_END
