#import <UIKit/UIKit.h>
#import "ZBWebModel.h"
#import "ZBSelectPayMentView.h"
#import "ZBBasicViewController.h"
#import <WebKit/WebKit.h>
#import "ZBFabuTuijianSelectedItemVC.h"
@interface ZBToolWebViewController : ZBBasicViewController
@property (nonatomic , strong) WKWebView *wkWeb;
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic , copy) NSDictionary *parameterDic;
@property (nonatomic , strong) ZBWebModel *model;
@property (nonatomic , strong) UIWebView *webView;
@end
