#import "ZBBasicViewController.h"
typedef NS_ENUM(NSInteger, typeListNum)
{
    typeListOne = 1,
    typeListTwo = 2,
    typeListThree = 3,
    typeListFore = 4,
    typeListFive = 5,
};
@interface ZBNewRecommandVC : ZBBasicViewController
@property (nonatomic, retain)NSString *titleStr;
@property (nonatomic, assign)typeListNum typeList;
@end
