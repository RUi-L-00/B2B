//
//  JMProjectManager.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMProjectManager.h"
#import "JMAppVersionTool.h"

@interface JMProjectManager()
@property (nonatomic, strong) JMAppVersionTool *appVersionTool;
@end


@implementation JMProjectManager
singleton_implementation(JMProjectManager)

@synthesize loginUser=_loginUser;

#pragma mark - 登录用户缓存
-(void)setLoginUser:(JMLoginUserModel *)loginUser{
    if(loginUser){
        _loginUser = loginUser;
        [_loginUser save];
    }else{
        [_loginUser clear];
        _loginUser = loginUser;
    }
}

-(JMLoginUserModel *)loginUser{
    if(_loginUser == nil){
        if([JMFileManagerHelper isExistsAtPath:kLoginUserSavePath]){
            _loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile:kLoginUserSavePath];
        }
    }
    return _loginUser;
}

#pragma mark - 登录
//登录
-(void)loginWithParams:(NSDictionary *)params successBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock{
    [[JMRequestManager sharedManager] POST:kAccount_UrlLogin parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            failBlock(response.errorMsg);
        }else{
            JMLoginUserModel *user = [[JMLoginUserModel alloc] initWithLoginDictionary:response.responseObject[@"data"]];
            self.loginUser = user;
            successBlock();
        }
    }];
}

//第三方登录
-(void)thirdLoginWithType:(UMSocialPlatformType)type successBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock{
    [JMUMengHelper getUserInfoForPlatform:type completion:^(UMSocialUserInfoResponse *result, NSError *error) {
        if(error){
            failBlock(@"授权失败");
            return;
        }
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
        
        //调用自己服务器的授权登录接口
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        [params setJsonValue:resp.name key:@"nick"];
        NSString *requestType = @"0";
        switch (type) {
            case UMSocialPlatformType_QQ:
                requestType = @"2";
                break;
            case UMSocialPlatformType_WechatSession:
                requestType = @"0";
                break;
            case UMSocialPlatformType_Sina:
                requestType = @"1";
                break;
            default:
                break;
        }
        [params setJsonValue:requestType key:@"authorize"];
        [params setJsonValue:resp.iconurl key:@"imgUrl"];
        [params setJsonValue:resp.uid key:@"ids"];
        
        [[JMRequestManager sharedManager] POST:kAccount_UrlLoginAuthorize parameters:params completion:^(JMBaseResponse *response) {
            if(response.error){
                if(response.statusCode == 3){
                    //初次授权，需要绑定手机号码。此时没有返回登录数据，登录数据在绑定手机接口返回
                    AccountBindPhoneVC *bindPhoneVC = [[AccountBindPhoneVC alloc] initWithStoryboardName:@"RegisterAndLogin"];
                    bindPhoneVC.ids = response.responseObject[@"data"];
                    bindPhoneVC.completeBlock = ^(JMBaseResponse *bindResponse) {
                        if(bindResponse.error){
                            //绑定手机不成功
                            if(failBlock){
                                failBlock(bindResponse.errorMsg);
                            }
                        }else{
                            //成功
                            JMLoginUserModel *user = [[JMLoginUserModel alloc] initWithLoginDictionary:bindResponse.responseObject[@"data"]];
                            self.loginUser = user;
                            if(successBlock){
                                successBlock();
                            }
                        }
                    };
                    [[UIWindow jm_currentViewController].navigationController pushViewController:bindPhoneVC animated:YES];
                }else{
                    //出错
                    if(failBlock){
                        failBlock(response.errorMsg);
                    }
                }
            }else{
                //非初次授权
                JMLoginUserModel *user = [[JMLoginUserModel alloc] initWithLoginDictionary:response.responseObject[@"data"]];
                self.loginUser = user;
                if(successBlock){
                    successBlock();
                }
            }
        }];
    }];
}

//登出
-(void)logoutWithSuccessBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kAccount_UrlLogout parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            failBlock(response.errorMsg);
        }else{
            self.loginUser = nil;
            successBlock();
        }
    }];
}

//获取登录用户详情
-(void)updateLoginUserInfoSuccessBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kAccount_UrlLoginUserInfo parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            if(failBlock){
                failBlock(response.errorMsg);
            }
        }else{
            [self.loginUser updateWithUserInfoDictionary:response.responseObject[@"data"]];
            [self.loginUser save];
            if(successBlock){
                successBlock();
            }
        }
    }];
}
#pragma mark -
-(void)loadRootVC {
    //TODO 此处还可以添加引导页、广告页
//    if(self.loginUser){
        [self showMainViewController];
//    }else{
//        [self showLoginViewController];
//    }
}

-(void)showLoginViewController{
    AccountLoginVC *loginVC = [[AccountLoginVC alloc] initWithStoryboard];
    JMNavigationController *nav = [[JMNavigationController alloc] initWithRootViewController:loginVC];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

-(void)showMainViewController{
    JMTabBarController *tab = [[JMTabBarController alloc] init];
    [UIApplication sharedApplication].delegate.window.rootViewController = tab;
}

#pragma mark - 版本检测
-(void)versionCheck:(BOOL)showAlert{
    if(self.appVersionTool == nil){
        _appVersionTool = [[JMAppVersionTool alloc] init];
    }
    [self.appVersionTool versionCheck:showAlert];
}
@end
