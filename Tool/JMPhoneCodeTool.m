//
//  JMPhoneCodeTool.m
//  XPBiPro
//
//  Created by liuny on 2018/5/17.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMPhoneCodeTool.h"
#import "JMRegularExp.h"

@interface JMPhoneCodeTool()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, readwrite) NSInteger secondsSendAgain;//重发间隔
@property (nonatomic, weak) UIButton *phoneCodeButton;
@property (nonatomic, assign) JMPhoneCodeType type;
@end

@implementation JMPhoneCodeTool
-(instancetype)initWithPhoneCodeButton:(UIButton *)phoneCodeButton type:(JMPhoneCodeType)type{
    self = [super init];
    if(self){
        self.phoneCodeButton = phoneCodeButton;
        self.type = type;
        [self initControl];
        [self initData];
    }
    return self;
}

-(void)initControl{
    
}

-(void)initData{
    _secondsSendAgain = 60;
}

-(void)timerAction{
    _secondsSendAgain--;
    NSString *title = [NSString stringWithFormat:@"%lds",_secondsSendAgain];
    [self.phoneCodeButton setTitle:title forState:UIControlStateDisabled];
    if(_secondsSendAgain == 0){
        [self stopTimer];
        self.phoneCodeButton.enabled = YES;
        _secondsSendAgain = 60;
        [self.phoneCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.phoneCodeButton setTitle:@"重新发送" forState:UIControlStateDisabled];
    }
}

//停止计时
-(void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

//开始计时
-(void)startTimer{
    if(self.timer == nil){
        //初始化定时器，使用timerWithTimeInterval此种方法初始化不会立刻触发
        JMWeak(self);
        if (@available(iOS 10.0, *)) {
            _timer = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
                [weakself timerAction];
            }];
        } else {
            // iOS10.0之前
            _timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        }
    }
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    self.phoneCodeButton.enabled = NO;
}

-(NSMutableDictionary *)paramsForType:(JMPhoneCodeType)type{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    NSString *requestType;
    switch (type) {
        case JMPhoneCodeType_BindPhone:
            requestType = @"2";
            break;
        case JMPhoneCodeType_ForgetPassword:
            requestType = @"2";
            break;
        case JMPhoneCodeType_Register:
            requestType = @"1";
            break;
        case JMPhoneCodeType_Login:
            requestType = @"0";
            break;
        default:
            break;
    }
    [params setJsonValue:requestType key:@"type"];
    return params;
}

/**
 发送验证码
 */
-(void)sendPhoneCode{
    //判断手机号是否为空
    if(self.phoneNum.length == 0){
        [JMProgressHelper toastInWindowWithMessage:@"请输入手机号码"];
        return;
    }
    //验证手机的格式
//    BOOL isMoblie = [JMRegularExp isValidateMobile:self.phoneNum];
//    if(isMoblie == NO){
//        [JMProgressHelper toastInWindowWithMessage:@"手机号码格式错误"];
//        return;
//    }
    NSMutableDictionary *params = [self paramsForType:self.type];
    [params setJsonValue:self.phoneNum key:@"key"];
    //网络请求
    [[JMRequestManager sharedManager] POST:kAccount_UrlGetVerificationCode parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            //弹框提示
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [self startTimer];
        }
    }];
}

@end
