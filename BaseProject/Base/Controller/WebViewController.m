//
//  WebViewController.m
//  BaseProject
//
//  Created by LiGuicai on 15/6/25.
//  Copyright (c) 2015年 game. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) WebViewJavascriptBridge *jsBridge;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    __weak __typeof(self)weakSelf = self;
    self.jsBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        id responseDataFromObjC = [weakSelf receivedWebviewAction:data];
        responseCallback(responseDataFromObjC);
    }];
    
    [self loadUrl:self.url];
   
    
}

- (void)loadUrl:(NSString *)urlString {
    
    if ([urlString rangeOfString:[[NSBundle mainBundle] resourcePath]].location != NSNotFound) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:urlString isDirectory:NO]]];
    }
    else {
        NSURL *url = [NSURL URLWithString:urlString];
        if ( ! [[url scheme] length]) {
            url = [NSURL URLWithString:[@"http://" stringByAppendingString:urlString]];
        }
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (id)receivedWebviewAction:(id)dictionary {
    // TODO:
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWitGKequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //禁用长按弹出行为表单
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout = \"none\""];
    
    if ([self shouldShowHtmlInnerTitle]) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    DDLogError(@"%@", error);
}

@end
