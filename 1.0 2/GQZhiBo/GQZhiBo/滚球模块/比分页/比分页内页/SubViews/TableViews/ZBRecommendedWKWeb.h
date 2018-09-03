#import <WebKit/WebKit.h>
#import "ZBWebModel.h"
@interface ZBRecommendedWKWeb : WKWebView
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic , strong) ZBWebModel *model;
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)reloadData;
@end
