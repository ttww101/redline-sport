#import <UIKit/UIKit.h>
#import "ZBLiveScoreModel.h"
#import <WebKit/WebKit.h>
@interface ZBJiBenWebView : UIWebView
@property (nonatomic, strong) ZBLiveScoreModel *model;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
