//
//  WebViewController.h
//  BaseProject
//
//  Created by LiGuicai on 15/6/25.
//  Copyright (c) 2015年 game. All rights reserved.
//

#import "BaseViewController.h"
#import <WebViewJavascriptBridge.h>

@interface WebViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, assign) BOOL shouldShowHtmlInnerTitle; //是否显示网页自带的标题
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, copy) NSString *url;

- (void)loadUrl:(NSString *)urlString;

- (id)receivedWebviewAction:(id)dictionary;

@end
