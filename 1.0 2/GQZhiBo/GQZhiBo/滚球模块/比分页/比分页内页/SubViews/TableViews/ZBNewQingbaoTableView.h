//
//  ZBNewQingbaoTableView.h
//  GQapp
//
//  Created by WQ_h on 16/5/9.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewQingbaoTableViewDelegate <NSObject>
- (void)headerRefreshNewQB;
@end
@interface ZBNewQingbaoTableView : ZBBasicTableView
@property (nonatomic, strong) NSArray *arrData;

//主队情报
@property (nonatomic, strong) NSArray *arrhomeInfo;
//客队情报
@property (nonatomic, strong) NSArray *arrawayInfo;
//中立情报
@property (nonatomic, strong) NSArray *arrneutralInfo;
//极点数据
@property (nonatomic, strong) NSMutableArray *jiDianArr;

@property (nonatomic, weak) id<NewQingbaoTableViewDelegate>delegateNewQB;

@property (nonatomic, assign) BOOL cellCanScroll;

@end
