//
//  ServerHallViewController.m
//  HarryPay
//
//  Created by Harry.Deng on 15/1/6.
//  Copyright (c) 2015年 Harry.Deng. All rights reserved.
//

#import "ServerHallViewController.h"

@interface ServerHallViewController () <UIWebViewDelegate>

@end

@implementation ServerHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Size.width, Main_Size.height - StatusBar_Height - Navbar_Height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_serverHallUrl]]];
    webView.delegate = self;
    webView.backgroundColor = RGBS(49);
    [self.view addSubview:webView];
    
    UILabel *l = [GlobalMethod BuildLableWithFrame:CGRectMake(50, 15, Main_Size.width - 100, 20) withFont:[UIFont boldSystemFontOfSize:13] withText:@"由 www.harry.com 提供"];
    l.textColor = RGBS(118);
    l.textAlignment = NSTextAlignmentCenter;
    [webView insertSubview:l atIndex:0];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"webview URL : %@", request.URL.absoluteString);
    
    //请求本次urlRequest
    if ([request.URL.absoluteString isEqualToString:_serverHallUrl]) {
        return YES;
    }
    
    //含有其他的请求（非http/https）
    if ([request.URL.absoluteString hasPrefix:@"alipays://"]) {
        return YES;
    }
    
    if ([request.URL.absoluteString hasPrefix:@"http://itunes.apple.com/cn/app/id"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:request.URL.absoluteString]];
        return YES;
    }
    
    
    ServerHallViewController *shVC = [ServerHallViewController quickInstance];
    shVC.serverHallUrl = request.URL.absoluteString;
    [self.navigationController pushViewController:shVC animated:YES];
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
