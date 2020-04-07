//
//  Pay.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef Pay_h
#define Pay_h

//------外部可识别的文件-----
#import "PayVC.h"
#import "PayResultVC.h"
#import "PayUploadCertificateAlert.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kPay_UrlGetDefaultAddress       fPinUrl(@"api/address/list")//获取默认地址
#define kPay_UrlBuyNowOrder             fPinUrl(@"api/order/create")//创建立即购买订单
#define kPay_UrlShoppingCartOrder       fPinUrl(@"api/order/createCart")//创建购物车订单
#define kPay_UrlUploadCertificate       fPinUrl(@"api/order/payOrder")//上传支付凭证

#endif /* Pay_h */
