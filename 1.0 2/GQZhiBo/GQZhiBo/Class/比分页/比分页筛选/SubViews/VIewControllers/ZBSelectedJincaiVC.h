#import "ZBSelectedAllVC.h"
#import "ZBBasicViewController.h"
@protocol SelectedJincaiVCDelegate <NSObject>
@optional
- (void)confirmSelectedJincaiWithData:(NSArray *)arrSaveData;
@end
@interface ZBSelectedJincaiVC : ZBBasicViewController
@property (nonatomic, weak) id<SelectedJincaiVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic) typeSaishiSelecterdVC type;

@property (nonatomic) NSString *tab; //sclass （赛事,默认）or pankou_rq （让球盘口）or pankou_dx （大小盘口）
@property (nonatomic) NSString *timeline; // live 即时(默认)，old 赛果，new 赛程

@end
