//
//  GlobalHtmlVC.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GlobalHtmlVC.h"

@interface GlobalHtmlVC ()

@end

@implementation GlobalHtmlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = NO;
}

-(void)initControl{
    
}

-(void)initData{
    switch (self.type) {
        case Html_Register:
            self.title = @"用户协议";
            [self requestHtmlContent:@"3"];
            break;
        case Html_FuWu:
            self.title = @"服务协议";
            break;
        case Html_YinSi:
            self.title = @"隐私政策";
            break;
        default:
            break;
    }
}

// 默认需要, 是否需要进度条
- (BOOL)webViewController:(JMWebViewController *)webViewController webViewIsNeedProgressIndicator:(WKWebView *)webView{
    return NO;
}

#pragma mark - 网络
-(void)requestHtmlContent:(NSString *)type{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:type key:@"id"];
    [[JMRequestManager sharedManager] POST:kGlobal_UrlHtmlContent parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *type = [dataDic getJsonValue:@"type"];
            if(type.intValue == 0){
                NSString *htmlContent = [dataDic getJsonValue:@"content"];
                [self.webView loadHTMLString:htmlContent baseURL:nil];
            }
        }
    }];
}
@end
