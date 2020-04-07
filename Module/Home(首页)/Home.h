//
//  Home.h
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef Home_h
#define Home_h

//------外部可识别的文件-----
#import "HomeVC.h"
#import "HomeSearchVC.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)
#define kHome_NotificationStartRefreshing            @"kHome_NotificationStartRefreshing"
#define kHome_NotificationEndRefreshing              @"kHome_NotificationEndRefreshing"

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kHome_UrlAds                    fPinUrl(@"api/shop/index/ads")//首页轮播图
#define kHome_UrlClassification         fPinUrl(@"api/goods/label/topList")//首页商品分类置顶
#define kHome_UrlRecommendGoodsPage     fPinUrl(@"api/goods/recommendGoodsPage")//首页商品推荐列表
#define kHome_UrlHotGoodsPage           fPinUrl(@"api/goods/hotGoodsPage")//首页商品热门列表
#define kHome_UrlNewGoodsPage           fPinUrl(@"api/goods/newGoodsPage")//首页商品最新列表

#endif /* Home_h */
