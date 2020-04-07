//
//  OrderModel.m
//  JMBaseProject
//
//  Created by ios on 2019/12/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(instancetype)initWithTest{
    self = [super init];
    if(self){
        self.orderNo = @"67464433";
        NSMutableArray *goodsArray = [[NSMutableArray alloc] init];
        int count = arc4random()%4 + 1;
        for(int i=0;i<count;i++){
            GoodModel *good = [[GoodModel alloc] initWithTest];
            [goodsArray addObject:good];
        }
        self.goods = goodsArray;
        self.state = JMOrderState_WaitShouHuo;
        
        AddressModel *address = [[AddressModel alloc] initWithTest];
        self.address = address;
        
        self.createTime = @"2018-10-20 15:30:12";
        self.shenHeTime = @"2018-10-20 15:30:12";
        self.payTime = @"2018-10-20 15:30:12";
        self.faHuoTime = @"2018-10-20 15:30:12";
        self.completeTime = @"2018-10-20 15:30:12";
        self.mark = @"产品非常好！产品非常好！产品非常好！";
        self.reviewImage = @"goodPlaceholder";
    }
    return self;
}

-(instancetype)initWithOrderListDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        //TODO
        self.orderId = [dict getJsonValue:@"id"];
        self.orderNo = [dict getJsonValue:@"orderNo"];
        NSMutableArray *goodsArray = [[NSMutableArray alloc] init];
        for (NSDictionary *goodDic in dict[@"goodsList"]) {
            GoodModel *good = [[GoodModel alloc] initWithOrderDic:goodDic];
            [goodsArray addObject:good];
        }
        self.goods = goodsArray;
        self.state = [dict getJsonValue:@"state"].integerValue;
        self.totalPay = [dict getJsonValue:@"money"];
        self.reviewImage = [dict getJsonValue:@"payProof"];
    }
    return self;
}

-(instancetype)initWithDetailDictionary:(NSDictionary *)dict{
    self = [self initWithOrderListDictionary:dict];
    if(self){
        //TODO
        self.orderId = [dict getJsonValue:@"id"];
        self.orderNo = [dict getJsonValue:@"orderNo"];
        self.afterId = [dict getJsonValue:@"refundId"];
        NSMutableArray *goodsArray = [[NSMutableArray alloc] init];
        for (NSDictionary *goodDic in dict[@"goodsList"]) {
            GoodModel *good = [[GoodModel alloc] initWithOrderDic:goodDic];
            [goodsArray addObject:good];
        }
        self.goods = goodsArray;
        self.state = [dict getJsonValue:@"state"].integerValue;
        self.totalPay = [dict getJsonValue:@"money"];
        
        self.address = [[AddressModel alloc] initWithOrderDic:dict];
        self.reviewImage = [dict getJsonValue:@"payProof"];
        self.logisticsNo = [dict getJsonValue:@"expressNo"];
        self.mark = [dict getJsonValue:@"desc"];
        
        //时间
        self.createTime = [dict getJsonValue:@"createTime"];
        self.payTime = [dict getJsonValue:@"payTime"];
        self.faHuoTime = [dict getJsonValue:@"sendTime"];
//        self.evaluateTime = [dict getJsonValue:@"refundTime"];
        self.shenHeTime = [dict getJsonValue:@"auditTime"];
        self.shenHeReason = [dict getJsonValue:@"auditFailedReason"];
        self.completeTime = [dict getJsonValue:@"finishTime"];
        self.endTime = [dict getJsonValue:@"updateTime"];
    }
    return self;
}

@end
