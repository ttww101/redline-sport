//
//  ZBTuijianDatingTableView.h
//  GQapp
//
//  Created by WQ_h on 16/8/3.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicTableView.h"
#import "ZBTuijianDatingCell.h"
#import "ZBLiveScoreModel.h"
@protocol TuijianDatingTableViewDelegate <NSObject>
@optional

@end

@interface ZBTuijianDatingTableView : ZBBasicTableView
@property (nonatomic, assign) typeTuijianCell type;
@property (nonatomic, weak) id <TuijianDatingTableViewDelegate> delegateTuijianDatingTableView;

@property (nonatomic, strong) ZBLiveScoreModel *model;


//是否显示下拉刷新
@property (nonatomic, assign) BOOL hideFooter;
@property (nonatomic, assign) BOOL cellCanScroll;

@end
