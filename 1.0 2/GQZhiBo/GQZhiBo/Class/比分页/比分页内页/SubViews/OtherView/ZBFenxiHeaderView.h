@protocol FenxiHeaderViewDelegate <NSObject>

- (void)backClick:(NSInteger)btnTag;

- (void)tapPlayVideoAction:(NSArray *)signalArray;

@end

#import <UIKit/UIKit.h>
#import "ZBLiveScoreModel.h"



@interface ZBFenxiHeaderView : UIView
@property (nonatomic, strong) UIButton *imageRight;
@property (nonatomic, weak)id<FenxiHeaderViewDelegate>delegate;
@property (nonatomic, strong) ZBLiveScoreModel *model;
- (void)hideBottom;
- (void)showBottom;
- (void)changeCountTimeWithTime:(NSString *)countTime;
- (void)updateScroeWithmodel:(ZBLiveScoreModel *)liviModel;
@end
