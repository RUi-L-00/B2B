//
//  ShoppingCart.h
//  JMBaseProject
//
//  Created by ios on 2019/12/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef ShoppingCart_h
#define ShoppingCart_h

//------外部可识别的文件-----
#import "ShoppingCartVC.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kShoppingCart_UrlPageCart           fPinUrl(@"api/goods/cart/goodsList")//购物车列表
#define kShoppingCart_UrlDelCart            fPinUrl(@"api/goods/cart/del")//删除购物车
#define kShoppingCart_UrlEditCart           fPinUrl(@"api/goods/editCart")//编辑购物车商品数量

#endif /* ShoppingCart_h */
