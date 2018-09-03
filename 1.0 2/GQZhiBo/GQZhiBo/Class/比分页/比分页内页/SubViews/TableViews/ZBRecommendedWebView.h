#import <UIKit/UIKit.h>
#import "ZBWebModel.h"
@interface ZBRecommendedWebView : UIWebView
@property (nonatomic , strong) ZBWebModel *model;
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)reloadData;
- (void)cancleLoadData;
@end
