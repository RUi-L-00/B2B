//
//  Categories.h
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef Categories_h
#define Categories_h

//------外部可识别的文件-----
#import "CategoriesModel.h"

#import "CategoriesVC.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kCategories_UrlCategories       fPinUrl(@"api/goods/label/list")//获取商品分类
#define kCategories_UrlGoodsList        fPinUrl(@"api/goods/page")//获取商品列表

#endif /* Categories_h */
