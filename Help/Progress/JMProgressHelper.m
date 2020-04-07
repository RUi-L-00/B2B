//
//  JMProgress.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/15.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMProgressHelper.h"

@implementation JMProgressHelper
+(void)toastInWindowWithMessage:(NSString *)message{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.label.text=message;
    hud.label.font= [UIFont systemFontOfSize:15];
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //代表需要蒙版效果
    
    //    hud.dimBackground = YES;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    // X秒之后再消失
    [hud hideAnimated:YES afterDelay:3];
}

+(void)toastInWindowWithMessage:(NSString *)message dismissBlock:(void (^)(void))block{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=message;
        hud.label.font= [UIFont systemFontOfSize:15];
        hud.label.numberOfLines = 0;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        //代表需要蒙版效果
    //    hud.dimBackground = YES;
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        // 消息之后执行的操作
        hud.completionBlock = block;
        // X秒之后再消失
        [hud hideAnimated:YES afterDelay:3];
}

+(void)toastInView:(UIView *)view message:(NSString *)message{
    
}

+(void)toastInView:(UIView *)view message:(NSString *)message dismissBlock:(void(^)(void))block{
    
}
@end
