//
//  JMRegularExp.m
//  JMBaseProject
//
//  Created by Liuny on 2019/12/20.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMRegularExp.h"

@implementation JMRegularExp


/**
 国际号码验证

 @param mobileNumbel 要验证的号码
 @return YES通过  NO不通过
 */
+ (BOOL)isValidateMobileGuoJi:(NSString *)mobileNumbel{
    
    NSString *aaa = @"^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$";
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aaa];
    if (([regextestct evaluateWithObject:mobileNumbel]
         )) {
        return YES;
    }
    return NO;
}

/**
 验证码手机号

 @param mobileNum 手机号
 @return YES 通过 NO 不通过
 */
+ (BOOL)isValidateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,1700,199
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[5-8]|8[0-9]|9[89])\\d{8}$";

    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
   
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";

    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
   // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
   // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  校验金额格式
 *
 *  @param money 金额
 *
 *  @return 结果
 */
+ (BOOL)isValidateMoney:(NSString*)money{
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1,2})?$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:money
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, money.length)];
          
    if(numberofMatch > 0){
        return YES;
    }
    return NO;
}

/**
 *  验证邮箱格式
 *
 *  @param email 邮箱地址
 *
 *  @return 结果
 */
+ (BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

/**
 *  验证是否包含emoji表情
 *
 *  @param string 字符串
 *
 *  @return 结果
 */
+ (BOOL)isContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

/**
 *  验证是否为有效的身份证号码
 *
 *  @param identityCard 身份证号码
 *
 *  @return 结果
 */
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

/**
 *  验证是否为有效的银行卡账号
 *
 *  @param value 账号
 *
 *  @return 结果
 */
+ (BOOL)isValidCreditNumber:(NSString*)value{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[value length];
    int lastNum = [[value substringFromIndex:cardNoLength-1] intValue];
    
    value = [value substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [value substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}



/*数字验证(只能输入数字)*/
+(BOOL)isValidateNum:(NSString *)number
{
    NSString *numRegex = @"^[0-9]*$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numRegex];
    return [numTest evaluateWithObject:number];
}

/*汉字验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateRealName:(NSString *)name
{
    NSString *alph = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *realNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alph];
    
    return [realNameTest evaluateWithObject:name];
}

/*特殊符号验证*/
+(BOOL)isValidateSymbol:(NSString *)symbol{
    NSString *sym = @"[^a-zA-Z0-9]";
    NSPredicate *symTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",sym];
    return [symTest evaluateWithObject:symbol];
}

@end
