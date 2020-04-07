//
//  JMUMengHelper.h
//  iOSProject
//
//  Created by HuXuPeng on 2017/12/29.
//  Copyright © 2017年 HuXuPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMShare/UMShare.h>


/*
 参考文档：https://developer.umeng.com/docs/128606/detail/129443
 使用方法：
 1、配置SSO白名单，就是plist中添加
 2、配置URL Scheme
 3、AppDelegate中的配置
 -(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
     BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
     return result;
 }
 如果使用微博，必须添加如下方法，不然不会回调
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
     //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
     BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
     if (!result) {
         // 其他如支付等SDK的回调
     }
     return result;
 }
*/

@interface JMUMengHelper : NSObject

#pragma mark - UM分享
/**
 初始化第三方登录和分享
 */
+ (void)UMSocialStart;
/// 分享网页
/// @param type 三方APP类型
/// @param title 标题
/// @param subTitle 副标题
/// @param thumbImage 图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param shareUrl 网址
+(void)shareWebWithType:(UMSocialPlatformType)type title:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(id)thumbImage shareUrl:(NSString *)shareUrl;
/// 分享文本
/// @param type 三方APP类型
/// @param content 文本内容
+ (void)shareTextWithType:(UMSocialPlatformType)type content:(NSString *)content;
/// 分享图片
/// @param type 三方APP类型
/// @param image 图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param thumbImage 缩略图（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
+ (void)shareImageWithType:(UMSocialPlatformType)type image:(id)image thumbImage:(id)thumbImage;
/// 分享音乐
/// @param type 三方APP类型
/// @param title 标题
/// @param subTitle 副标题
/// @param thumbImage 缩略图 （支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param musicUrl 音乐地址
+ (void)shareMusicWithType:(UMSocialPlatformType)type title:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(id)thumbImage musicUrl:(NSString *)musicUrl;
/// 分享视频
/// @param type 三方APP类型
/// @param title 标题
/// @param subTitle 副标题
/// @param thumbImage 缩略图 （支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param videoUrl 视频地址
+ (void)shareVedioWithType:(UMSocialPlatformType)type title:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(id)thumbImage videoUrl:(NSString *)videoUrl;

#pragma mark - UM第三方登录
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(void(^)(UMSocialUserInfoResponse *result, NSError *error))completion;

#pragma mark - UM统计
/*!
 * 启动友盟统计功能
 */
+ (void)UMAnalyticStart;
/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView;

/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)endLogPageView:(__unsafe_unretained Class)pageView;


/*!
 * 自定义名称
 */
/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+(void)beginLogPageViewName:(NSString *)pageViewName;

/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+(void)endLogPageViewName:(NSString *)pageViewName;
@end
