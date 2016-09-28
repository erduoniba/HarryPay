//
//  FindPasswordViewController.m
//  HarryPay
//
//  Created by Harry on 15/1/15.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "FindPasswordViewController.h"

@interface FindPasswordViewController () <UIWebViewDelegate>

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, StatusBar_Height + Navbar_Height, Main_Size.width, Main_Size.height - StatusBar_Height - Navbar_Height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webViewUrl]]];
    webView.delegate = self;
    webView.backgroundColor = RGBS(49);
    [self.view addSubview:webView];
    
    UILabel *l = [GlobalMethod BuildLableWithFrame:CGRectMake(50, 15, Main_Size.width - 100, 20) withFont:[UIFont boldSystemFontOfSize:13] withText:@"由 www.harry.com 提供".localize];
    l.textColor = RGBS(118);
    l.textAlignment = NSTextAlignmentCenter;
    [webView insertSubview:l atIndex:0];
    
    [self setBackItemName:@"返回"];
}

- (void)backBarButtonItem{
    [self dismissViewControllerAnimated:NO completion:Nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"webview URL : %@", request.URL.absoluteString);

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}

@end
