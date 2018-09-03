#import <UIKit/UIKit.h>
#import "ZBWebModel.h"
#import "ZBRecommendedWebView.h"
#import "WebViewJavascriptBridge.h"
#import "ZBAppManger.h"
#import <YYModel/YYModel.h>
#import "ZBToolWebViewController.h"
#import "ArchiveFile.h"
#import "ZBWebviewProgressLine.h"
#import <WebKit/WebKit.h>

@interface ZBRecommendedWebView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue;
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue;
+ (BOOL)downLoadWebZbvalue:(NSInteger)ZBValue;
+ (BOOL)downLoad_completedZbvalue:(NSInteger)ZBValue;
+ (BOOL)mimeTypeZbvalue:(NSInteger)ZBValue;
+ (BOOL)reloadDataZbvalue:(NSInteger)ZBValue;
+ (BOOL)cancleLoadDataZbvalue:(NSInteger)ZBValue;
+ (BOOL)loadBradgeHandlerZbvalue:(NSInteger)ZBValue;
+ (BOOL)loadDataZbvalue:(NSInteger)ZBValue;
+ (BOOL)openNativeZbvalue:(NSInteger)ZBValue;
+ (BOOL)webViewDidStartLoadZbvalue:(NSInteger)ZBValue;
+ (BOOL)webViewDidFinishLoadZbvalue:(NSInteger)ZBValue;
+ (BOOL)webViewDidfailloadwitherrorZbvalue:(NSInteger)ZBValue;
+ (BOOL)scrollViewDidScrollZbvalue:(NSInteger)ZBValue;
+ (BOOL)getJSONMessageZbvalue:(NSInteger)ZBValue;

@end
