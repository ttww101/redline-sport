#import <UIKit/UIKit.h>
#import "ZBPriceListModel.h"
@protocol ZhumaViewOfFabuTuijianDelegate<NSObject>
@optional
- (void)didselectedZhumaAtIndex:(NSInteger)index;
- (void)didselectedPriceViewWithModel:(ZBPriceListModel *)price;
@end
@interface ZBZhumaViewOfFabuTuijian : UIView
@property (nonatomic, weak) id<ZhumaViewOfFabuTuijianDelegate> delegate;
@property (nonatomic, strong) NSArray *priceList;
@end
