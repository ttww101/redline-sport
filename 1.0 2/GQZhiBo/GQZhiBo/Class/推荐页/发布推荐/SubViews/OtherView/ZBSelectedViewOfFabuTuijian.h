#import <UIKit/UIKit.h>
#import "ZBDxModel.h"
@protocol SelectedViewOfFabuTuijianDelegate <NSObject>
@optional
- (void)didselectedAtIndex:(NSInteger)index WithModel:(ZBDxModel *)selectedModel WithCompanyIndex:(NSInteger)companyIndex;
@end
@interface ZBSelectedViewOfFabuTuijian : UIView
@property (nonatomic, assign)NSInteger newTypeNum;
@property (nonatomic, assign)NSInteger companyIndex;
@property (nonatomic, strong) ZBDxModel *model;
@property (nonatomic, weak) id<SelectedViewOfFabuTuijianDelegate> delegate;
- (void)clearbackGroundImage;
- (void)setCurrentIndex:(NSInteger )index;
@end
