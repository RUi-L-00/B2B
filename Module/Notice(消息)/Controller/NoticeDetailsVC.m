//
//  NoticeDetailsVC.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "NoticeDetailsVC.h"

@interface NoticeDetailsVC () <WKNavigationDelegate, WKUIDelegate>

@property (weak, nonatomic) IBOutlet UIView *webBgView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation NoticeDetailsVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Notice"];
}

- (void)initControl {
    self.title = @"消息详情";
    
    [self.webBgView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.webBgView);
    }];
}

- (void)initData {
    if (kUseTestData) {
        NSString *htmlStr = @"消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正\
        文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文\
        消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消\
        息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息\
        正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正\
        文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文\
        消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消\
        息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息\
        内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文消息内容正文";
        [self.webView loadHTMLString:htmlStr baseURL:nil];
    } else {
        [self requestData];
    }
}

#pragma mark -网络请求
- (void)requestData {
    
}

#pragma mark -懒加载
- (WKWebView *)webView {
    if (!_webView) {
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
        // UI代理
        _webView.UIDelegate = self;
    }
    return _webView;
}

@end
