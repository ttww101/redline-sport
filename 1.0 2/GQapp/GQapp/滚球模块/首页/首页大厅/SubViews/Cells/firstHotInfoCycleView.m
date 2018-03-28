//
//  firstHotInfoCycleView.m
//  GQapp
//
//  Created by WQ on 2017/7/18.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#import "FirstQBView.h"
#import "LivingModel.h"
#import "firstHotInfoCycleView.h"
@interface firstHotInfoCycleView()<UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, weak) UICollectionView *mainView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIPageControl *pagecontrol;

@end
@implementation firstHotInfoCycleView

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
        [self setupMainView];

    }
    return self;
}

- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    
    [self.mainView reloadData];
    _pagecontrol.numberOfPages = self.arrData.count;//这里设置数量

}
- (UIPageControl *)pagecontrol
{
    if (!_pagecontrol) {
        _pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 160, 200, 30)];
        [_pagecontrol setCenter:CGPointMake(self.width/2, _pagecontrol.center.y)];
        _pagecontrol.currentPage = 0;
        _pagecontrol.pageIndicatorTintColor = colorEE;
        _pagecontrol.currentPageIndicatorTintColor = redcolor;
//        _pagecontrol.backgroundColor = redcolor;
        //        [_pagecontrol addTarget:self action:@selector(pagecontrolChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _pagecontrol;
}

// 设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    _flowLayout.itemSize = CGSizeMake(Width, 160);
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width, 160) collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[FirstQBView class] forCellWithReuseIdentifier:@"FirstQBViewcell"];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    _mainView = mainView;
    
    
    [self addSubview:self.pagecontrol];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FirstQBView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstQBViewcell" forIndexPath:indexPath];
    cell.model = [self.arrData objectAtIndex:indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(dicSelectedToFenxiWithModel:)]) {
        
        
        [_delegate dicSelectedToFenxiWithModel:[self.arrData objectAtIndex:indexPath.item]];
    }

}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = [self currentIndex];
    NSLog(@"%d",itemIndex);
    _pagecontrol.currentPage = itemIndex;
    
}


- (int)currentIndex
{
    if (_mainView.width == 0 || _mainView.width == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_mainView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}
- (void)setUpData:(NSArray *)arr{
    //    for (int i = 0; i < _arrView.count; i ++) {
    //        FirstQBView *cellInfo = _arrView[i];
    //        cellInfo.model = arr[i];
    //    }
    
    for (int i = 0; i < arr.count; i++) {
        LivingModel *living = [arr objectAtIndex:i];
        for (int j = 0; j < _arrData.count; j ++)
        {
            FirstPInfoListModel *model = _arrData[j];
            
            if (living.sid == model.mid) {
                model.matchstate = living.code;
                model.homescore = living.hsc;
                model.guestscore = living.gsc;
                model.matchtime2 = living.htime;
                
            }
            
            
            
        }
        
        
    }
    
    
    [self.mainView reloadData];
}

@end
