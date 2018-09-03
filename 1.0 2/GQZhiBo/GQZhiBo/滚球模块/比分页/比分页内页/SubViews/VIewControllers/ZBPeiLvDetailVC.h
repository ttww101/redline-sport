#import "ZBBasicTableView.h"
#import "ZBLiveScoreModel.h"
typedef NS_ENUM(NSInteger,PeiLvCellType){
    isBeforeTwo = 0,
    isAfterTwo = 1,
};
@interface ZBPeiLvDetailVC : ZBBasicViewController
@property (nonatomic, strong) ZBLiveScoreModel                        *model;
@property (nonatomic, assign) PeiLvCellType                         PeiLvCType;
@end
