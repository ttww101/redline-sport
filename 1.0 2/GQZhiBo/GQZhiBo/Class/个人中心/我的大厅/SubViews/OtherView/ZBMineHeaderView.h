#import <UIKit/UIKit.h>
@interface ZBMineHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic , strong) ZBUserModel *model;

@property (nonatomic , copy) NSDictionary *dic;


@end
