//
//  Notice.h
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#ifndef Notice_h
#define Notice_h

//------外部可识别的文件-----
#import "NoticeVC.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kNotice_UrlNoticePage             fPinUrl(@"api/notice/page")//通知列表
//#define kShoppingCart_UrlDelCart            fPinUrl(@"api/goods/delCart")//删除购物车
//#define kShoppingCart_UrlEditCart           fPinUrl(@"api/goods/editCart")//编辑购物车商品数量

#endif /* Notice_h */
