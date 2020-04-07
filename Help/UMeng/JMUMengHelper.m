//
//  JMUMengHelper.m
//  iOSProject
//
//  Created by HuXuPeng on 2017/12/29.
//  Copyright © 2017年 HuXuPeng. All rights reserved.
//

#import "JMUMengHelper.h"
#import "AppDelegate.h"

// 友盟
NSString *const UMAppKey = @"58aa7d20e88bad08c1001dcd";

// UM 微信
NSString *const WeChatAppKey = @"wxdc1e388c3822c80b";
NSString *const WeChatAppSecret = @"3baf1193c85774b3fd9d18447d76cab0";
NSString *const WeChatRedirectURL = @"http://mobile.umeng.com/social";

// UM QQ
NSString *const QQAppKey = @"1105821097";
NSString *const QQAppSecret = @"ublD75ttNYKh0zXx";
NSString *const QQRedirectURL = @"http://mobile.umeng.com/social";

//UM 微博
NSString *const WeiBoAppKey = @"";
NSString *const WeiBoAppSecret = @"";
NSString *const WeiBoRedirectURL = @"";


@implementation JMUMengHelper

#pragma mark - 分享
+ (void)UMSocialStart{
    // 友盟分享
    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];
    
    //微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppKey appSecret:WeChatAppSecret redirectURL:WeChatRedirectURL];
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppKey  appSecret:QQAppSecret redirectURL:QQRedirectURL];
    //微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WeiBoAppKey  appSecret:WeiBoAppSecret redirectURL:WeiBoRedirectURL];
#ifdef DEBUG
    //打开调试日志
    [UMConfigure setLogEnabled:YES];
#endif
}

/// 分享网页
/// @param type 三方APP类型
/// @param title 标题
/// @param subTitle 副标题
/// @param thumbImage 图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param shareUrl 网址
+(void)shareWebWithType:(UMSocialPlatformType)type title:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(id)thumbImage shareUrl:(NSString *)shareUrl{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImage];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error){
        if (error) {
            [JMProgressHelper toastInWindowWithMessage:@"分享失败"];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                JMLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                JMLog(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                JMLog(@"response data is %@",data);
            }
        }
    }];
}

/// 分享文本
/// @param type 三方APP类型
/// @param content 文本内容
+ (void)shareTextWithType:(UMSocialPlatformType)type content:(NSString *)content{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = content;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            [JMProgressHelper toastInWindowWithMessage:@"分享失败"];
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}

/// 分享图片
/// @param type 三方APP类型
/// @param image 图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param thumbImage 缩略图（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
+ (void)shareImageWithType:(UMSocialPlatformType)type image:(id)image thumbImage:(id)thumbImage{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = thumbImage;
    shareObject.shareImage = image;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            [JMProgressHelper toastInWindowWithMessage:@"分享失败"];
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}

/// 分享音乐
/// @param type 三方APP类型
/// @param title 标题
/// @param subTitle 副标题
/// @param thumbImage 缩略图 （支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param musicUrl 音乐地址
+ (void)shareMusicWithType:(UMSocialPlatformType)type title:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(id)thumbImage musicUrl:(NSString *)musicUrl{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImage];
    //设置音乐网页播放地址
    shareObject.musicUrl = musicUrl;
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            [JMProgressHelper toastInWindowWithMessage:@"分享失败"];
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}



/// 分享视频
/// @param type 三方APP类型
/// @param title 标题
/// @param subTitle 副标题
/// @param thumbImage 缩略图 （支持UIImage，NSdata以及图片链接Url NSString类对象集合）
/// @param videoUrl 视频地址
+ (void)shareVedioWithType:(UMSocialPlatformType)type title:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(id)thumbImage videoUrl:(NSString *)videoUrl{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImage];
    //设置视频网页播放地址
    shareObject.videoUrl = videoUrl;
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            [JMProgressHelper toastInWindowWithMessage:@"分享失败"];
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}



#pragma mark - 第三方登录
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(void(^)(UMSocialUserInfoResponse *result, NSError *error))completion
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        JMLog(@" uid: %@", resp.uid);
        JMLog(@" openid: %@", resp.openid);
        JMLog(@" accessToken: %@", resp.accessToken);
        JMLog(@" refreshToken: %@", resp.refreshToken);
        JMLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        JMLog(@" name: %@", resp.name);
        JMLog(@" iconurl: %@", resp.iconurl);
        JMLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        JMLog(@" originalResponse: %@", resp.originalResponse);
        
        completion(resp, error);
        
    }];
}

#pragma mark - 统计
+ (void)UMAnalyticStart {
    // 友盟统计
    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];
#ifdef DEBUG
    //打开调试日志
    [UMConfigure setLogEnabled:YES];
#endif
}

+ (void)beginLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
}

+ (void)endLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick endLogPageView:NSStringFromClass(pageView)];
}

+(void)beginLogPageViewName:(NSString *)pageViewName
{
    [MobClick beginLogPageView:pageViewName];
}

+(void)endLogPageViewName:(NSString *)pageViewName
{
    [MobClick endLogPageView:pageViewName];
}

@end
