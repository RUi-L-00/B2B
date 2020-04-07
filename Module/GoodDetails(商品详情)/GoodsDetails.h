//
//  GoodsDetails.h
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef GoodsDetails_h
#define GoodsDetails_h

//------外部可识别的文件-----
#import "GoodModel.h"

#import "GoodsDetailsVC.h"
#import "GoodsDetailsSelectSpecificationAlert.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kGoodsDetails_UrlGoodsDetails           fPinUrl(@"api/goods/detail")//商品详情
#define kGoodsDetails_UrlGetPrice               fPinUrl(@"api/goods/getPrice")//根据规格属性参数获取价格接口
#define kGoodsDetails_UrlAddCar                 fPinUrl(@"api/goods/cart/saveOrUpdate")//加入购物车

#endif /* GoodsDetails_h */
