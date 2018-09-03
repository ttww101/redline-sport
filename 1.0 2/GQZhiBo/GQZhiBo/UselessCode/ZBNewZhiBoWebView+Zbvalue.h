#import <UIKit/UIKit.h>
#import "ZBLiveScoreModel.h"
#import <WebKit/WebKit.h>
#import "ZBNewZhiBoWebView.h"
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"

@interface ZBNewZhiBoWebView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue;
+ (BOOL)changIndexZbvalue:(NSInteger)ZBValue;
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue;
+ (BOOL)loadDataZhiBoZbvalue:(NSInteger)ZBValue;
+ (BOOL)scrollViewDidScrollZbvalue:(NSInteger)ZBValue;

@end
