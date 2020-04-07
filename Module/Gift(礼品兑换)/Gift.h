//
//  Gift.h
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#ifndef Gift_h
#define Gift_h
//------外部可识别的文件-----
#import "GiftDetailsVC.h"
#import "GiftVC.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)

//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kGift_UrlPage                    fPinUrl(@"api/gift/page")//礼品列表(用户没登陆)
#define kGift_UrlPageByAccount           fPinUrl(@"api/gift/order/pageByAccount")//礼品列表(用户登陆)


#endif /* Gift_h */
