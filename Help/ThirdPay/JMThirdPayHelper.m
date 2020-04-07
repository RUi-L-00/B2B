//
//  ThirdPayHelper.m
//  JMBaseProject
//
//  Created by 徐凌峰 on 2018/8/8.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMThirdPayHelper.h"

// info.plist中定义的url scheme
NSString *const APPScheme_Alipay = @"haiyitong";
// 微信appkey 
NSString *const WX_APP_KEY = @"wx7bb485349ec74054";

@interface JMThirdPayHelper () <WXApiDelegate>

@property (nonatomic, copy) void(^payResultBlock)(BOOL success);

@end

@implementation JMThirdPayHelper
singleton_implementation(JMThirdPayHelper)

- (void)start {
    //微信支付
    [WXApi registerApp:WX_APP_KEY];
}

- (void)handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
                if (self.payResultBlock) {
                    self.payResultBlock(YES);
                }
            }
            else {
                if (self.payResultBlock) {
                    self.payResultBlock(NO);
                }
            }
        }];
    }
    else {
        [WXApi handleOpenURL:url delegate:self];
    }
}

#pragma mark -- 三方支付

- (void)paymentWithData:(id)data type:(PaymentType)type completionBlock:(void (^)(BOOL))completionBlock {
    self.payResultBlock = completionBlock;
    
    switch (type) {
        case PaymentTypeAlipay:
            [self paymentByAlipayWithRetOrderStr:data];
            break;
        case PaymentTypeWechat:
            [self paymentByWeChatPayWithretDict:data];
            break;
            
        default:
            break;
    }
}

-(void)paymentByWeChatPayWithretDict:(NSDictionary *)retDict {
    // 先判断是否已安装微信客户端
    if(![WXApi isWXAppInstalled]) {
        [JMProgressHelper toastInWindowWithMessage:@"您还未安装微信客户端"];
        return;
    }
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [retDict objectForKey:@"appid"];
    req.partnerId           = [retDict objectForKey:@"partnerid"];
    req.prepayId            = [retDict objectForKey:@"prepayid"];
    req.nonceStr            = [retDict objectForKey:@"noncestr"];
    req.timeStamp           = (UInt32)[[retDict objectForKey:@"timestamp"] longLongValue];
    req.package             = [retDict objectForKey:@"package"];
    req.sign                = [retDict objectForKey:@"sign"];
    
    [WXApi sendReq:req];
}

-(void)paymentByAlipayWithRetOrderStr:(NSString *)orderStr {
    //  调起支付宝客户端，支付结果回调
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:APPScheme_Alipay callback:^(NSDictionary *resultDic) {
        // 网页支付回调block
        if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
            if (self.payResultBlock) {
                self.payResultBlock(YES);
            }
        }
        else {
            if (self.payResultBlock) {
                self.payResultBlock(NO);
            }
        }
    }];
}

#pragma mark -- WXApiDelegate

- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
            {
                if (self.payResultBlock) {
                    self.payResultBlock(YES);
                }
            }
                break;
            default:
            {
                if (self.payResultBlock) {
                    self.payResultBlock(NO);
                }
            }
                break;
        }
    }
}

@end
