//
//  AddressModel.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initWithTest{
    self = [super init];
    if(self){
        self.sheng = @"广东省";
        self.shi = @"广州市";
        self.qu = @"黄埔区";
        self.isSelect = NO;
        self.name = @"利达";
        self.phone = @"186240132021";
        self.address = @"天猫国际城110层10室";
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.addressId = [dict getJsonValue:@"id"];
        self.isDefault = [dict getJsonValue:@"isChoice"].boolValue;
        self.sheng = [dict getJsonValue:@"sheng"];
        self.shi = [dict getJsonValue:@"shi"];
        self.qu = [dict getJsonValue:@"qu"];
        self.address = [dict getJsonValue:@"address"];
        self.phone = [dict getJsonValue:@"mobile"];
        self.name = [dict getJsonValue:@"name"];
    }
    return self;
}

-(instancetype)initWithOrderDic:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.address = [dict getJsonValue:@"address"];
        self.phone = [dict getJsonValue:@"addressPhone"];
        self.name = [dict getJsonValue:@"addressName"];
    }
    return self;
}

-(NSString *)allAddress{
    NSString *rtn = [NSString stringWithFormat:@"%@%@%@%@",self.sheng,self.shi,self.qu,self.address];
    return rtn;
}

@end
