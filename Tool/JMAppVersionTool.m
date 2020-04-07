//
//  JMAppVersionTool.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/16.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMAppVersionTool.h"

@interface JMAppVersionTool()
@property (nonatomic, copy) NSString *downloadUrl;
@end

//https://itunes.apple.com/cn/app/id1144816653?mt=8


@implementation JMAppVersionTool
-(void)versionCheck:(BOOL)showAlert{
    [self versionCheckForCompany:showAlert];
}

//企业版本发布版本检测
-(void)versionCheckForCompany:(BOOL)showAlert{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setJsonValue:@"1" key:@"type"];
    [[JMRequestManager sharedManager] POST:kUrlAppVersion parameters:nil completion:^(JMBaseResponse *response) {
        if(response.error){
            if(showAlert){
                [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            }
        }else{
            //接口数据解析
            NSDictionary *result = response.responseObject[@"data"];
            if(result == nil){
                return;
            }
            NSString *versionCode = result[@"name"];
            NSString *appPath = [result getJsonValue:@"url"];
            NSString *versionDes = [result getJsonValue:@"desc"];
            NSString *isNeed = [result getJsonValue:@"state"];
            
            NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            BOOL flag = [versionCode compare:localVersion options:NSNumericSearch] == NSOrderedDescending;
            if(flag){
                NSString *message = [NSString stringWithFormat:@"最新版本(%@)，当前版本(%@)\n%@",versionCode,localVersion,versionDes];
                //不是最新版本
                self.downloadUrl = appPath;
                if(isNeed.intValue == 1){
                    //强制更新
                    [UIAlertController jm_showAlertWithTitle:@"软件版本更新" message:message appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.addActionCancelTitle(@"立即更新");
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        if(buttonIndex == 0){
                            [self downloadNew];
                        }
                    }];
                }else{
                    //非强制更新
                    [UIAlertController jm_showAlertWithTitle:@"软件版本更新" message:message appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.addActionCancelTitle(@"立即更新");
                        alertMaker.addActionDefaultTitle(@"稍后更新");
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        if(buttonIndex == 0){
                            //更新
                            [self downloadNew];
                        }
                    }];
                }
            }else{
                //已是最新版本
                if(showAlert){
                    [UIAlertController jm_showAlertWithTitle:@"提示" message:@"您当前已是最新版本。" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.addActionCancelTitle(@"确定");
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        
                    }];
                }
            }
        }
    }];
}

//AppStore版本检测
-(void)versionCheckForAppStore{
    NSString *url = @"http://itunes.apple.com/lookup?id=977118117";
    [[JMRequestManager sharedManager] POST:url parameters:nil completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSArray *resultArray = response.responseObject[@"results"];
            if(resultArray.count > 0){
                NSDictionary *firstOne = resultArray[0];
                NSString *versionStr = firstOne[@"version"];
                self.downloadUrl = [firstOne getJsonValue:@"trackViewUrl"];
                JMLog(@"---version[%@]---",versionStr);
                
                NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                BOOL flag = [versionStr compare:localVersion options:NSNumericSearch] == NSOrderedDescending;
                if(flag){
                    //有新版本
                    NSString *message = [NSString stringWithFormat:@"新版本%@已发布！",versionStr];
                    [UIAlertController jm_showAlertWithTitle:@"软件版本更新" message:message appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.addActionCancelTitle(@"立即更新");
                        alertMaker.addActionDefaultTitle(@"稍后更新");
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        if(buttonIndex == 0){
                            //更新
                            [self downloadNew];
                        }
                    }];
                }else{
                    //无新版本
                }
            }
        }
    }];
}

//带多个小数点的版本判断
-(BOOL)versionCompare:(NSString *)versionStr{
    BOOL rtn = NO;
    NSArray *array = [versionStr componentsSeparatedByString:@"."];
    NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    
    NSInteger maxCount = array.count>localArray.count?array.count:localArray.count;
    for(int i=0;i<maxCount;i++){
        int server = 0;
        if(array.count > i){
            NSString *serverVersion = array[i];
            server = serverVersion.intValue;
        }
        int local = 0;
        if(localArray.count > i){
            NSString *localStr = localArray[i];
            local = localStr.intValue;
        }
        if(server == local){
            continue;
        }else{
            rtn = server>local?YES:NO;
            break;
        }
    }
    return rtn;
}

-(void)downloadNew{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downloadUrl]];
}
@end
