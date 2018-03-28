//
//  TuijianDetailTableView.h
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
#import "BasicTableView.h"
#import "TuijiandatingModel.h"
#import "payUserModel.h"
@interface TuijianDetailTableView : BasicTableView
//推荐详情的数据
@property (nonatomic, strong) TuijiandatingModel *headerModel;

//评论数据
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, assign) typeTuijianDetailHeaderCell typeTuijianDetailHeader;
@property (nonatomic, strong) TuijiandatingModel *tuijianModel;
@property (nonatomic, strong) payUserModel *payUsersModel;
@property (nonatomic ,strong) NSArray *arrPic;
@end
