//
//  Address.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef Address_h
#define Address_h

//------外部可识别的文件-----
#import "AddressModel.h"

#import "AddressVC.h"
#import "AddressSelectVC.h"
#import "AddressSelectCityAlert.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)
#define  kAddress_NotificationUpdataList        @"kAddress_NotificationUpdataList"

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kAddress_UrlAddressList         fPinUrl(@"api/address/list")//获取地址列表
#define kAddress_UrlEditAddress         fPinUrl(@"api/address/edit")//编辑地址
#define kAddress_UrlAddAddress          fPinUrl(@"api/address/add")//新增地址
#define kAddress_UrlAddressSheng        fPinUrl(@"api/area/getByShengList")//获取省份列表
#define kAddress_UrlAddressShi          fPinUrl(@"api/area/getByShiList")//获取市列表
#define kAddress_UrlAddressQu           fPinUrl(@"api/area/getByQuList")//获取区列表

#endif /* Address_h */
