typedef NS_ENUM(NSInteger, typeSaishiSelecterdVC)
{
    typeSaishiSelecterdVCBifen = 0,
    typeSaishiSelecterdVCTuijian = 1,
    typeSaishiSelecterdVCInfo = 2,
};
#import "ZBBasicViewController.h"
@protocol SelectedAllVCDelegate <NSObject>
@optional
- (void)confirmSelectedAllWithData:(NSArray *)arrSaveData;
@end
@interface ZBSelectedAllVC : ZBBasicViewController
@property (nonatomic, weak) id<SelectedAllVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic) typeSaishiSelecterdVC type;
@end
