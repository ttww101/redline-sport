//
//  FansTable.m
//  GQapp
//
//  Created by WQ on 2017/4/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define  cellFansTable @"cellFansTable"
#import "FansTable.h"
#import "FansCell.h"
@interface FansTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end
@implementation FansTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.defaultTitle = @"";
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[FansCell class] forCellReuseIdentifier:cellFansTable];
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;

    }
    return self;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.mj_header beginRefreshing];
}

//返回单张图片
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if ([self.defaultTitle isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
        
    }
    if ([self.defaultTitle isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    NSString *text = self.defaultTitle;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (_arrData.count==0) {
//        return nil;
//    }

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 10)];
    header.backgroundColor = colorTableViewBackgroundColor;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (_arrData.count==0) {
//        return 0;
//    }
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FansCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFansTable];
    if (!cell) {
        cell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFansTable];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    FansModel *model = [_arrData objectAtIndex:indexPath.row];
    cell.model = model;
//    cell.textLabel.text = model.nickname;
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
