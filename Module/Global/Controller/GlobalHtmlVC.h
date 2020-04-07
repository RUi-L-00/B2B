//
//  GlobalHtmlVC.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    Html_Register = 0,//注册协议
    Html_FuWu,//服务协议
    Html_YinSi,//隐私协议
}Html_Type;


@interface GlobalHtmlVC : JMWebViewController
@property(nonatomic, assign) Html_Type type;
@end

NS_ASSUME_NONNULL_END
