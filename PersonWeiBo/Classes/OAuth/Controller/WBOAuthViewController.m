//
//  WBOAuthViewController.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/26.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBOAuthViewController.h"

#import "WBAccountTool.h"
#import "WBRootTool.h"

@interface WBOAuthViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示登陆的网页
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.webView = webView;
    webView.delegate = self;
    
    // 请求授权
    // 拼接URLString
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",WBAuthorizeBaseURL, WBclient_id, WBredirect_uri];
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 加载网页
    [self.webView loadRequest:request];
    
}

#pragma mark - 换取accessToken
- (void)accessTokenWithCode:(NSString *)code {
    
    [WBAccountTool accountWithCode:code success:^{
        [WBRootTool chooseRootViewController:WBKeyWindow];
    } failure:^{
        //WBLog(@"授权失败!---error : %@", error);
    }];
}

#pragma mark - UIWebView delegate
// UIWebView即将加载的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 提示用户正在加载
    [MBProgressHUD showMessage:@"正在加载..."];
}
// UIWebView加载完成时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 移除提示框
    [MBProgressHUD hideHUD];
}
// 加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 移除提示框
    [MBProgressHUD hideHUD];
}
// 一般是用来拦截UIWebView的请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
    // 获取code
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length > 0) {
        //WBLog(@"%@", urlStr);
        NSRange codeRange = NSMakeRange(range.location + range.length, WB_access_token_length);
        NSString *code = [urlStr substringWithRange:codeRange];
        //WBLog(@"%@", code);
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
