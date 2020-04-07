//
//  UserCenter.h
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#ifndef UserCenter_h
#define UserCenter_h
//------外部可识别的文件-----
#import "UserCenterMyGiftVC.h"
#import "UserCenterMainVC.h"
//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
//#define kGift_UrlPage                    fPinUrl(@"api/gift/order/page")//礼品列表(用户没登陆)
#define kGift_UrlBudgetCount             fPinUrl(@"api/account/integral/budget/count")//用户的积分余额

#endif /* UserCenter_h */
