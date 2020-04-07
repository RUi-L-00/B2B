//
//  JMPhoneCodeTool.h
//  XPBiPro
//
//  Created by liuny on 2018/5/17.
//  Copyright © 2018年 liuny. All rights reserved.
//
/**
 发送验证码封装
 */
#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    JMPhoneCodeType_Login = 0,//登录
    JMPhoneCodeType_Register,//注册
    JMPhoneCodeType_ForgetPassword,//忘记密码
    JMPhoneCodeType_BindPhone,//绑定手机号
}JMPhoneCodeType;

@interface JMPhoneCodeTool : NSObject
@property(nonatomic,strong) NSString *phoneNum;
@property(nonatomic,strong) NSString *areaId;
/**
 初始化

 @param phoneCodeButton 点击发送验证码的按钮
 @return JMPhoneCodeTool对象
 */
-(instancetype)initWithPhoneCodeButton:(UIButton *)phoneCodeButton type:(JMPhoneCodeType)type;
/**
 发送验证码
 */
-(void)sendPhoneCode;

/**
 停止计时(退出时销毁)
 */
-(void)stopTimer;
@end
