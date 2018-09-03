//
//  ZBTuijianDetailTableView.h
//  GQapp
//
//  Created by WQ_h on 16/8/4.
//  Copyright © 2016年 GQXX. All rights reserved.
//
//推荐详情页的tableView
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
//推荐详情的数据
@property (nonatomic, strong) ZBTuijiandatingModel *headerModel;

//评论数据
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, assign) typeTuijianDetailHeaderCell typeTuijianDetailHeader;
@property (nonatomic, strong) ZBTuijiandatingModel *tuijianModel;
@property (nonatomic, strong) ZBpayUserModel *payUsersModel;
@property (nonatomic ,strong) NSArray *arrPic;
@end
