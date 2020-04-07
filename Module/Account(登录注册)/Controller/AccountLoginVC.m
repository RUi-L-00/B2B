//
//  AccountLoginVC.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/15.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "AccountLoginVC.h"
#import "AccountRegisterVC.h"
#import "AccountForgetPasswordVC.h"

@interface AccountLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation AccountLoginVC

-(instancetype)initWithStoryboard{
    return [self initWithStoryboardName:@"Account"];
}

-(void)initControl{
    self.title = @"登录";
     self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
}

-(void)initData{

}

- (UIImage *)jmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(JMNavigationBar *)navigationBar{
    return nil;
}

-(NSArray<UIButton *> *)textViewControllerRelationButtons:(JMTextViewController *)textViewController{
    return @[self.loginButton];
}

#pragma mark - Actions
- (IBAction)loginAction:(id)sender {
//    //登录
    NSString *phone = self.phoneTF.text;
    if (phone.length == 0) {
        [JMProgressHelper toastInWindowWithMessage:self.phoneTF.placeholder];
        return;
    }
    NSString *password = self.pwdTF.text;
    if (password.length == 0) {
        [JMProgressHelper toastInWindowWithMessage:self.pwdTF.placeholder];
        return;
    }
     [[JMProjectManager sharedJMProjectManager] showMainViewController];
    [self requestNormalLogin];
}

- (IBAction)registerAction:(id)sender {
    //注册
    AccountRegisterVC *vc = [[AccountRegisterVC alloc] initWithStoryboard];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)acceptInfoAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    //注册协议
     GlobalHtmlVC *htmlVC = [[GlobalHtmlVC alloc] init];
    if (button.tag == 0) {
         htmlVC.type = Html_FuWu;
    }else{
        htmlVC.type = Html_YinSi;
    }
    [self.navigationController pushViewController:htmlVC animated:YES];
}


- (IBAction)forgetPasswordAction:(id)sender {
    //忘记密码
    AccountForgetPasswordVC *vc = [[AccountForgetPasswordVC alloc] initWithStoryboard];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)thirdLoginAction:(UIButton *)sender {
    UMSocialPlatformType type;
    switch (sender.tag) {
        case 0:
            //QQ登录
            type = UMSocialPlatformType_QQ;
            break;
        case 1:
            //微信登录
            type = UMSocialPlatformType_WechatSession;
            break;
        case 2:
            //新浪登录
            type = UMSocialPlatformType_Sina;
            break;
        default:
            type = UMSocialPlatformType_WechatSession;
            break;
    }
    [self requestThirdLogin:type];
}

#pragma mark - 网络
-(void)requestNormalLogin{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTF.text key:@"email"];
    [params setJsonValue:self.pwdTF.text key:@"password"];
    [self showLoading];
    [[JMProjectManager sharedJMProjectManager] loginWithParams:params successBlock:^{
        //成功
        [self dismissLoading];
        [[JMProjectManager sharedJMProjectManager] showMainViewController];
    } failBlock:^(NSString *errorMsg) {
        //失败
        [self dismissLoading];
        [JMProgressHelper toastInWindowWithMessage:errorMsg];
    }];
}

-(void)requestThirdLogin:(UMSocialPlatformType)type{
    [[JMProjectManager sharedJMProjectManager] thirdLoginWithType:type successBlock:^{
        //成功
        [[JMProjectManager sharedJMProjectManager] showMainViewController];
    } failBlock:^(NSString *errorMsg) {
        //失败
        [JMProgressHelper toastInWindowWithMessage:errorMsg];
    }];
}
@end
