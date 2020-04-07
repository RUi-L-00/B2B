//
//  UserCenterSetupVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterSetupVC.h"
#import "UserCenterAboutusVC.h"
#import "UserCenterChangeMailboxVC.h"
#import "UserCenterChangePasswordVC.h"
@interface UserCenterSetupVC ()

@end

@implementation UserCenterSetupVC


- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}


-(void)initControl{
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
}


#pragma mark - Action
//更换邮箱
- (IBAction)changeMailboxAction:(id)sender {
    UserCenterChangeMailboxVC * changeMailboxVC = [[UserCenterChangeMailboxVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:changeMailboxVC animated:YES];
}

//更换密码
- (IBAction)changePasswordAction:(id)sender {
    UserCenterChangePasswordVC * changePasswordVC = [[UserCenterChangePasswordVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}
//关于我们
- (IBAction)aboutUsAction:(id)sender {
    UserCenterAboutusVC * aboutusVC = [[UserCenterAboutusVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:aboutusVC animated:YES];
}
//检查更新
- (IBAction)checkUpdatesAction:(id)sender {
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
    tipView.message = @"检查到最新版本，是否立即更新？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
        if(buttonIndex == 1){
           
        }
    };
    [self presentViewController:tipView animated:YES completion:nil];
}

//清除缓存
- (IBAction)clearCacheAction:(id)sender {
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
       tipView.message = @"确定清除缓存数据？";
       tipView.buttonTitles = @[@"取消",@"确定"];
       tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
           if(buttonIndex == 1){
              
           }
       };
       [self presentViewController:tipView animated:YES completion:nil];
}

//退出登录
- (IBAction)signoutAction:(id)sender {
    [[JMProjectManager sharedJMProjectManager] showLoginViewController];
}




@end
