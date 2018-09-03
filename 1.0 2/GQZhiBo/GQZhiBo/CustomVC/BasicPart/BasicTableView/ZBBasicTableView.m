//
//  ZBBasicTableView.m
//  GQapp
//
//  Created by WQ_h on 16/5/10.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicTableView.h"
@interface ZBBasicTableView()
@property (nonatomic, strong)UITableViewCell *seleCell;

@end
@implementation ZBBasicTableView

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
        self.defaultTitle = @"暂无数据";
    }
    return self;
}

    //返回单张图片
    //Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
    {
        return [UIImage imageNamed:@"d1"];
    }
    
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
    {
        NSLog(@"imageAnimationForEmptyDataSet");
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
        
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
        
        animation.duration = 0.25;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        
        return animation;
    }
    //返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
    {
        NSString *text = default_noMatch;
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    
    //返回详情文字
    //- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{ NSString *text = @"内容"; NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new]; paragraph.lineBreakMode = NSLineBreakByWordWrapping; paragraph.alignment = NSTextAlignmentCenter; NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph}; return [[NSAttributedString alloc] initWithString:text attributes:attributes]; }
    
    
    
    //按钮文字和图片只能显示一个，图片的优先级大于文字
    //返回可以点击的按钮 上面带文字
    //- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{ NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]}; return [[NSAttributedString alloc] initWithString:@"标题按钮" attributes:attributes];}
    //
    ////返回可以点击的按钮 上面带图片
    //- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{ return [UIImage imageNamed:@"defaultPic"];}
    
    //返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{ return [UIColor clearColor];}
    
    //自定义的view
    //- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{ UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; [activityView startAnimating]; return activityView;}
    //
    //此外,您还可以调整垂直对齐的内容视图(即:有用tableHeaderView时可见):
    //- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{ return -self.tableView.tableHeaderView.frame.size.height/2.0f;}
    
    
    
    //要求知道空的状态应该渲染和显示 (Default is YES) :

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}
    
    //是否允许点击 (默认是 YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}
    
    //是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
    
    //空白区域点击响应:
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{ // Do something
    
}
    
    //    点击button 响应
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ // Do something
    //    [self.tableView reloadData];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
    
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    _seleCell=[self cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _seleCell.backgroundColor = [UIColor whiteColor];
    
}

@end
