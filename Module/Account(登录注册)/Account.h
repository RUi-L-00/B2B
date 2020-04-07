//
//  Account.h
//  JMBaseProject
//
//  Created by Liuny on 2019/11/12.
//  Copyright © 2019 liuny. All rights reserved.
//

#ifndef Account_h
#define Account_h

//------外部可识别的文件-----
#import "AccountLoginVC.h"
#import "AccountBindPhoneVC.h"

//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kAccount_UrlLogin                   fPinUrl(@"api/account/loginByEmail")//邮箱登录
#define kAccount_UrlLoginAuthorize          fPinUrl(@"api/account/authorize")//第三方授权登录
#define kAccount_UrlLogout                  fPinUrl(@"api/account/logout")//登出
#define kAccount_UrlLoginUserInfo           fPinUrl(@"api/account/expand/getUserInfo")//获取登录用户信息
#define kAccount_UrlRegister                fPinUrl(@"api/account/registerByEmail")//注册
#define kAccount_UrlFindPassword            fPinUrl(@"api/account/find")//找回密码
#define kAccount_UrlThirdLoginBindPhone     fPinUrl(@"api/account/authorize")//第三方登录绑定手机号

#define kAccount_UrlGetVerificationCode     fPinUrl(@"api/account/getVerificationCode")//获取验证码
#endif /* Account_h */
