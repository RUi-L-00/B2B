//
//  JMRegularExp.h
//  JMBaseProject
//
//  Created by Liuny on 2019/12/20.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMRegularExp : NSObject

/**
 国际号码验证

 @param mobileNumbel 要验证的号码
 @return YES通过  NO不通过
 */
+ (BOOL)isValidateMobileGuoJi:(NSString *)mobileNumbel;
/**
 验证码手机号

 @param mobileNum 手机号
 @return YES 通过 NO 不通过
 */
+ (BOOL)isValidateMobile:(NSString *)mobileNum;
/**
 *  校验金额格式
 *
 *  @param money 金额
 *
 *  @return 结果
 */
+ (BOOL)isValidateMoney:(NSString*)money;
/**
 *  验证邮箱格式
 *
 *  @param email 邮箱地址
 *
 *  @return 结果
 */
+ (BOOL)isValidateEmail:(NSString *)email;
/**
 *  验证是否包含emoji表情
 *
 *  @param string 字符串
 *
 *  @return 结果
 */
+ (BOOL)isContainsEmoji:(NSString *)string;
/**
 *  验证是否为有效的身份证号码
 *
 *  @param identityCard 身份证号码
 *
 *  @return 结果
 */
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard;
/**
 *  验证是否为有效的银行卡账号
 *
 *  @param value 账号
 *
 *  @return 结果
 */
+ (BOOL)isValidCreditNumber:(NSString*)value;
/*数字验证(只能输入数字)*/
+(BOOL)isValidateNum:(NSString *)number;
/*汉字验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateRealName:(NSString *)name;
/*特殊符号验证*/
+(BOOL)isValidateSymbol:(NSString *)symbol;

@end

NS_ASSUME_NONNULL_END
