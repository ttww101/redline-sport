#import <Foundation/Foundation.h>
#import "ZBJSModel.h"
#import "WebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>
#import "ZBAppManger.h"
#import "ZBWebModel.h"
#import "ZBToolWebViewController.h"
#import "ZBDCTabBarController.h"
#import <YYModel/YYModel.h>
#import "ArchiveFile.h"

@interface ZBAppManger (Zbvalue)
+ (BOOL)shareInstanceZbvalue:(NSInteger)ZBValue;
+ (BOOL)initializeZbvalue:(NSInteger)ZBValue;
+ (BOOL)registerJSToolHannleZbvalue:(NSInteger)ZBValue;
+ (BOOL)WK_RegisterJSToolHannleZbvalue:(NSInteger)ZBValue;
+ (BOOL)initJavaScriptObserversZbvalue:(NSInteger)ZBValue;
+ (BOOL)getJSONMessageZbvalue:(NSInteger)ZBValue;

@end
