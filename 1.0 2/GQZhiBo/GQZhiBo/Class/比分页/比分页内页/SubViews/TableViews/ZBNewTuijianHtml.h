#import <UIKit/UIKit.h>
#import "ZBLiveScoreModel.h"
#import <WebKit/WebKit.h>
@interface ZBNewTuijianHtml : UIWebView
@property (nonatomic, strong) ZBLiveScoreModel *model;
@property (nonatomic, assign) NSInteger segIndex;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
