//
//  Order.h
//  JMBaseProject
//
//  Created by ios on 2019/11/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef Order_h
#define Order_h

//------外部可识别的文件-----
#import "OrderModel.h"

#import "OrderFooterView.h"
#import "OrderHeaderView.h"
#import "OrderGoodView.h"

#import "OrderCell.h"

#import "OrderDetailsVC.h"
#import "OrderListVC.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)
#define kOrder_NotificationOrderRefresh   @"kOrder_NotificationOrderRefresh"

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kOrder_UrlOrderList             fPinUrl(@"api/order/page")//获取订单列表
#define kOrder_UrlDeleteOrder           fPinUrl(@"api/order/delOrder")//删除订单
#define kOrder_UrlConfirmReceipt        fPinUrl(@"api/order/confirmReceipt")//确认收货
#define kOrder_UrlCancelOrder           fPinUrl(@"api/order/cancel")//取消订单
#define kOrder_UrlOrderDetail           fPinUrl(@"api/order/detail")//订单详情
#define kOrder_UrlLogistics             fPinUrl(@"api/order/logistics")//查询物流轨迹

#endif /* Order_h */
