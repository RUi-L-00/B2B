//
//  JMHttpUrl.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

/*
 *此处存放项目中接口请求url
 */

#ifndef JMHttpUrl_h
#define JMHttpUrl_h

//demo时候使用设为YES，接入接口后设置为NO
static BOOL kUseTestData = NO;

#if DEBUG
#define BaseUrl @"http://xpoa.vipgz2.idcfengye.com"
#define ImageBaseUrl @""
#else
#define BaseUrl @"http://xpoa.vipgz2.idcfengye.com"
#define ImageBaseUrl @""
#endif

#define fPinUrl(url) [NSString stringWithFormat:@"%@/%@",BaseUrl,url]

#define kUrlAppVersion              fPinUrl(@"api/app/selectAppVersion")//版本检测
#define kUrlSendCode                fPinUrl(@"api/account/code")//发送验证码


#endif /* JMHttpUrl_h */
