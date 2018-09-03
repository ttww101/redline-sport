#import "ZBSelectedAllVC.h"
#import "ZBBasicViewController.h"
@protocol SelectedChupanVCDelegate <NSObject>
@optional
- (void)confirmSelectedChupanWithData:(NSArray *)arrSaveData;
@end
@interface ZBSelectedChupanVC : ZBBasicViewController
@property (nonatomic, weak) id<SelectedChupanVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic) typeSaishiSelecterdVC type;
@end
