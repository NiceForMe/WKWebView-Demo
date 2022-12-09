//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by 李潇 on 2022/12/9.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKUIDelegate, WKNavigationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
    
    WKWebView *view = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:wkWebConfig];
    //遵循这个delegate 点“去这里”页面展示有问题，不遵循就没问题
    view.navigationDelegate = self;
    view.UIDelegate = self;
    
    NSString *url = @"https://uri.amap.com/marker?position=116.478346,39.997361";
    
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:view];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"Debug --- decidePolicyForNavigationAction url %@", webView.URL.description);
    decisionHandler(WKNavigationActionPolicyAllow);
}

//这里会报 Error Domain=NSURLErrorDomain Code=-1002 "unsupported URL"
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"Debug --- didFailProvisionalNavigation url %@", webView.URL.description);
}


@end
