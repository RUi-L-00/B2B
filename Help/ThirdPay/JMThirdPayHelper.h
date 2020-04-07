//
//  ThirdPayHelper.h
//  JMBaseProject
//
//  Created by 徐凌峰 on 2018/8/8.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>


/*
 使用步骤：
 plist中添加LSApplicationQueriesSchemes。设置：wechat、weixin
 URL types添加相应的微信和支付包
 
 1、在AppDelegate的didFinishLaunchingWithOptions中注册
 [[JMThirdPayHelper sharedJMThirdPayHelper] start];
 2、在AppDelegate的openURL中响应回调
 [[JMThirdPayHelper sharedJMThirdPayHelper] handleOpenURL:url];
 3、支付的地方调用(调用后台的接口获取订单信息)
 NSMutableDictionary *params = [NSMutableDictionary dictionary];
 [params setJsonValue:[LoginUser shareUser].sessionId key:@"sessionId"];
 [params setJsonValue:self.orderNo key:@"orderNo"];
 [params setJsonValue:@(type) key:@"payType"];
 
 [[JMRequestManager sharedManager] POST:kUrlPayWay parameters:params completion:^(JMBaseResponse *response) {
 if (response.error) {
 
 }else {
 MJWeakSelf;
 [[JMThirdPayHelper sharedJMThirdPayHelper] paymentWithData:response.responseObject[@"data"] type:type completionBlock:^(BOOL success) {
 
 }];
 }
 }];
 */


typedef NS_ENUM(NSUInteger, PaymentType) {
    PaymentTypeAlipay = 0,//支付宝
    PaymentTypeWechat = 1 //微信
};

@interface JMThirdPayHelper : NSObject 
singleton_interface(JMThirdPayHelper)

- (void)start;

// 支付
- (void)paymentWithData:(id)data type:(PaymentType)type completionBlock:(void(^)(BOOL success))completionBlock;

// 返回结果
- (void)handleOpenURL:(NSURL *)url;

@end
