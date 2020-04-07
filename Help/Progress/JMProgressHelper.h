//
//  JMProgress.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/15.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMProgressHelper : NSObject
//toast
+(void)toastInWindowWithMessage:(NSString *)message;
+(void)toastInWindowWithMessage:(NSString *)message dismissBlock:(void(^)(void))block;
+(void)toastInView:(UIView *)view message:(NSString *)message;
+(void)toastInView:(UIView *)view message:(NSString *)message dismissBlock:(void(^)(void))block;


@end
