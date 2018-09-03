//
//  ZBPanwangZhishuVC.m
//  GQapp
//
//  Created by WQ on 2017/8/23.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBPanwangZhishuVC.h"
#import "ZBTitleIndexView.h"
#import "ZBPanwangCollectCell.h"
#define cellPanwangCollect @"cellPanwangCollect"
@interface ZBPanwangZhishuVC ()<TitleIndexViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, weak) UICollectionView *mainView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) ZBTitleIndexView *titleView;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation ZBPanwangZhishuVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavView];
    
    
    _currentIndex = 0;
    _titleView = [[ZBTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    //    _titleView.bottomLineColor = [UIColor whiteColor];
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"亚盘",@"大小球",@"胜平负",];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];

    [NSFileManager defaultManager];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    _flowLayout.itemSize = CGSizeMake(Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - _titleView.height);
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar +  _titleView.height, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - _titleView.height) collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[ZBPanwangCollectCell class] forCellWithReuseIdentifier:cellPanwangCollect];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self.view addSubview:mainView];
    _mainView = mainView;
    

}
- (void)didSelectedAtIndex:(NSInteger)index
{
    _currentIndex = index;
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"盘王指数";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
        //right
        
        
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBPanwangCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellPanwangCollect forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0:
        {
            cell.type = @"1";
        }
            break;
        case 1:
        {
            cell.type = @"2";
        }
            break;
        case 2:
        {
            cell.type = @"0";
        }
            break;

        default:
            break;
    }

    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = [self getcurrentIndex];
    NSLog(@"%d",itemIndex);
//    if (itemIndex != _currentIndex) {
        [_titleView updateSelectedIndex:itemIndex];

//    }
}


- (int)getcurrentIndex
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
