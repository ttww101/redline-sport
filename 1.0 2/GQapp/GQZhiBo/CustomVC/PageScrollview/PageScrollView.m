//
//  PageScrollView.m
//  GQapp
//
//  Created by WQ on 2017/4/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "PageScrollView.h"
@interface PageScrollView ()<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger totalTableView;
@property (nonatomic, strong) NSMutableArray *arrTableView;
@end
@implementation PageScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
    }
    return self;
}
- (void)reloadData
{
    [self removeAllSubViews];
    if (_dateSource && [_dateSource respondsToSelector:@selector(numberOfIndexInPageSrollView:)]) {
        
        _totalTableView = [_dateSource numberOfIndexInPageSrollView:self];
        _arrTableView = [NSMutableArray array];
        self.contentSize = CGSizeMake(Width*_totalTableView, self.height);
        
        for (int i = 0; i<_totalTableView; i++) {
            
            UIView *tableView = [_dateSource pageScrollView:self tableViewForIndex:i];
            if (!tableView) {
                tableView = [UIView new];
            }
            tableView.frame = CGRectMake(Width*i, 0, Width, self.height);
            [self addSubview:tableView];
            [_arrTableView addObject:tableView];
            
        }
        
        if (_selectedIndex != 0) {
            [self updateSelectedIndex:_selectedIndex];
        }
        
        
    }
}

- (void)updateSelectedIndex:(NSInteger)index
{
    [self setContentOffset:CGPointMake(Width*index, 0) animated:NO];
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging---%d --- %f",decelerate,scrollView.contentOffset.x/Width);
    
    //setContentOffset 方法不会引起scrollview 的代理方法的调用，是分开执行的，所以不必担心会重复调用，陷入死循环中
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView    // called when scroll view grinds to a halt
{
    NSLog(@"scrollViewDidEndDecelerating");
    if (_pageDelegate && [_pageDelegate respondsToSelector:@selector(scrollToPageIndex:)]) {
        NSInteger index = (NSInteger)((scrollView.contentOffset.x + Width*0.5)/Width);
        NSLog(@"%ld",(long)index);
        if (index>=0 && index<=_totalTableView) {
            [_pageDelegate scrollToPageIndex:index];

        }
    }
}
@end


















