#import <UIKit/UIKit.h>
#import "ZBWebModel.h"
@interface ZBLiveQuizViewController : UIViewController
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic , copy) NSDictionary *parameterDic;
@property (nonatomic , strong) ZBWebModel *model;
@end
