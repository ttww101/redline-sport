#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ZBWebModel.h"
@interface ZBRecommendedWebView : WKWebView
@property (nonatomic , strong) ZBWebModel *model;
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)reloadData;
- (void)cancleLoadData;
@end
