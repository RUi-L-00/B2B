//
//  PaySelectSalesModel.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "PaySelectSalesModel.h"

@implementation PaySelectSalesModel

//假数据初始化方法
- (instancetype)initWithTest {
    if (self = [super init]) {
        self.salesId = @"000";
        self.salesName = @"张三";
        self.mailbox = @"12345678@qq.com";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.salesId = [dic getJsonValue:@""];
        self.salesName = [dic getJsonValue:@""];
        self.mailbox = [dic getJsonValue:@""];
    }
    return self;
}
@end
