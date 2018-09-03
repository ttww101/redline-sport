typedef NS_ENUM(NSInteger, typeTuijianDetailHeaderCell)
{
    typeTuijianDetailHeaderCellDanchang = 0,
    typeTuijianDetailHeaderCellChuanGuan = 1,
    typeTuijianDetailHeaderCellZucai = 2,
};
#import "ZBBasicTableView.h"
#import "ZBTuijiandatingModel.h"
#import "ZBpayUserModel.h"
@interface ZBTuijianDetailTableView : ZBBasicTableView
@property (nonatomic, strong) ZBTuijiandatingModel *headerModel;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, assign) typeTuijianDetailHeaderCell typeTuijianDetailHeader;
@property (nonatomic, strong) ZBTuijiandatingModel *tuijianModel;
@property (nonatomic, strong) ZBpayUserModel *payUsersModel;
@property (nonatomic ,strong) NSArray *arrPic;
@end
