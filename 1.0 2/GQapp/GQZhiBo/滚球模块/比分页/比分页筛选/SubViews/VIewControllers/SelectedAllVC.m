//
//  SelectedAllVC.m
//  GQapp
//
//  Created by WQ_h on 16/8/25.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "SelectedAllVC.h"
#import "AllSelectedView.h"
#import "DSCollectionViewIndex.h"
#import "BIfenSelectedSaishiModel.h"
#import "SelectedCCell.h"
#define CollectionCellSelectedAllVC @"CollectionCellSelectedAllVC"
#define CollectionHeaderSelectedAllVC @"CollectionHeaderSelectedAllVC"
#define cellTabelViewIndex @"cellTabelViewIndex"
#define cellCollectionHeight (29)
#define cellCollectionWidth ((Width - 25 - 20 - 30)/3)

@interface SelectedAllVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AllSelectedViewDelegate,DSCollectionViewIndexDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
//底部的全选按钮
@property (nonatomic, strong) AllSelectedView *allselectedV;
//@property (nonatomic, strong) UITableView *tableView;
//索引栏数据
@property (nonatomic, strong) NSArray *arrViewIndex;
//右边的索引栏
@property (nonatomic, strong) DSCollectionViewIndex *ViewIndex;
// 区头的数据
@property (nonatomic, strong) NSMutableArray *arrSectionData;
//cell的数据,大数组里面包含的是小数组
@property (nonatomic, strong) NSMutableArray *arrItemData;
//记录全选按钮是否要被全部选中
@property (nonatomic, assign) BOOL allBtnIsSelected;
//存放cell是否被选中
//@property (nonatomic, strong) NSMutableArray *arrCellIsselected;
//显示选中哪个字母
@property (nonatomic, strong) UILabel *flotageLabel;
@end

@implementation SelectedAllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _arrViewIndex = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self.view addSubview:self.allselectedV];
    self.allselectedV.btnAll.selected = _allBtnIsSelected;
    [self.view addSubview:self.collectionView];
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.ViewIndex];
    [self.view addSubview:self.flotageLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)flotageLabel
{
    if (!_flotageLabel) {
        _flotageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        _flotageLabel.center = CGPointMake(Width/2, (Height - 64 - _allselectedV.height)/2);
        _flotageLabel.backgroundColor = [UIColor blackColor];
        _flotageLabel.hidden = YES;
        [_flotageLabel.layer  setCornerRadius:32];
        _flotageLabel.layer.masksToBounds = YES;
        _flotageLabel.textAlignment = NSTextAlignmentCenter;
        _flotageLabel.textColor = [UIColor whiteColor];

    }
    return _flotageLabel;
}

- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    if (_arrData.count>0) {
        [self seperateData];
    }
}
- (void)seperateData
{
    _arrSectionData = [NSMutableArray array];
    _arrItemData = [NSMutableArray array];
    
    NSString *documentPath = [Methods getDocumentsPath];
    
    NSString *PatharrSaveAll = @"";
    if (_type == typeSaishiSelecterdVCBifen) {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];

        
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];

    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathinfo];
        
    }
    NSArray *arrsaveSaishi = [NSKeyedUnarchiver unarchiveObjectWithFile:PatharrSaveAll];
    
    for (int i = 0; i<_arrData.count; i++) {
        
        BIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
            //默认每次加载数据之后,全部选中
            model.isSelected = NO;
            
            _allBtnIsSelected = NO;

        }else{
    
            //如果没有记录这个页面的筛选,就默认为全选状态
            if (arrsaveSaishi.count == 0) {
                model.isSelected = NO;
                _allBtnIsSelected = NO;

            }else{
            model.isSelected = NO;
            for (int j = 0; j<arrsaveSaishi.count; j++) {
                BIfenSelectedSaishiModel *Savemodel = [arrsaveSaishi objectAtIndex:j];
                if (model.idId == Savemodel.idId) {
                    model.isSelected = YES;
                    break;
                }else{
                    model.isSelected = NO;
                    
                }
            }
        }
        }

        
        
        
        
        if (![_arrSectionData containsObject:model.index]) {
            //如果有区头的数组里面没有这个区头,就添加到区头数组里,并且在cell大数组里面创建一个小数组存放model
            [_arrSectionData addObject:model.index];
            NSMutableArray *arrItem = [NSMutableArray array];
            [arrItem addObject:model];
            [_arrItemData addObject:arrItem];
        }else{
            //如果有,就把大数组里面那个存放cell的小数组取出来,存放model
            NSInteger index = [_arrSectionData indexOfObject:model.index];
            NSMutableArray *arrItem = [_arrItemData objectAtIndex:index];
            [arrItem addObject:model];
        
        
        }
        
    }
    
    
    
}

- (AllSelectedView *)allselectedV
{
    if (!_allselectedV) {
        _allselectedV = [[AllSelectedView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 44)];
        _allselectedV.delegate = self;
    }
    return _allselectedV;
}
- (void)didSelectedAtBtnIndex:(NSInteger)index whtherSelected:(BOOL)selected
{
    
    if (index == 0) {
        for (int i = 0; i<_arrData.count; i++) {
            BIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
            model.isSelected = YES;

        }
        [self.collectionView reloadData];
    }else if (index == 1) {
        for (int i = 0; i<_arrData.count; i++) {
            BIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
            model.isSelected = NO;
        }
        [self.collectionView reloadData];
    }else if (index == 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(confirmSelectedAllWithData:)]) {
            
            
            NSMutableArray *arrMemory = [NSMutableArray arrayWithArray:_arrData];
            NSMutableArray *arrSend = [NSMutableArray array];
            for (int i = 0 ;i<arrMemory.count; i++) {
                BIfenSelectedSaishiModel *model = [arrMemory objectAtIndex:i];
                if (model.isSelected) {
                    [arrSend addObject:model];
                }
            }
            
//            //将上次筛选的记录到本地
//            NSString *documentPath = [Methods getDocumentsPath];
//            NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
//            [NSKeyedArchiver archiveRootObject:arrSend toFile:arrSaveBifenAllSelected];
            
            [_delegate confirmSelectedAllWithData:arrSend];
            
            
            
        }
    }
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        //区头的高度
        layout.headerReferenceSize = CGSizeMake(Width, 24);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SelectedCCell class] forCellWithReuseIdentifier:CollectionCellSelectedAllVC];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHeaderSelectedAllVC];
    }
    return _collectionView;
}

#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _arrSectionData.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *arr = [_arrItemData objectAtIndex:section];
    return arr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellSelectedAllVC forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    
    else{
//        //删除cell中的子对象,刷新覆盖问题。
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
    }
    
    NSMutableArray *arr = [_arrItemData objectAtIndex:indexPath.section];
    BIfenSelectedSaishiModel *model = [arr objectAtIndex:indexPath.row];
    
    cell.cellSize = CGSizeMake(cellCollectionWidth, cellCollectionHeight);
    cell.model = model;
    cell.selected = model.isSelected;

    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHeaderSelectedAllVC forIndexPath:indexPath];
    headerView.backgroundColor = colorTableViewBackgroundColor;
    [headerView removeAllSubViews];
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 24)];
    labTitle.textColor = color33;
    labTitle.font = font12;
    labTitle.text = _arrSectionData[indexPath.section];
    [headerView addSubview:labTitle];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    NSMutableArray *arr = [_arrItemData objectAtIndex:indexPath.section];
    BIfenSelectedSaishiModel *model = [arr objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [_allselectedV changeBtnSelectedState:model.isSelected];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
    
}

#pragma mark --  UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellCollectionWidth,cellCollectionHeight);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    上左下右
    return UIEdgeInsetsMake(15, 12, 12, 30);
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}





//
//#pragma mark -- UITableViewDataSource
//- (UITableView *)tableView
//{
//    if (!_tableView) {
//        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(Width - 20, 40, 20, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 40 - 40) style:UITableViewStylePlain];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellTabelViewIndex];
//        self.tableView.delegate =self;
//        self.tableView.dataSource = self;
//        self.tableView.rowHeight = 20;
//        self.tableView.scrollEnabled = NO;
//    }
//    return _tableView;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return _arrTableView.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    static NSString *NoCell = @"null";
//    //    UITableViewCell *cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoCell];
//    //    cellNull.selectionStyle = UITableViewCellSelectionStyleNone;
//    //    DcDefaultPageView *pageView = [[DcDefaultPageView alloc] initWithFrame:CGRectMake(0, 0, Width,(Width*350/750 + 80 + 25))];
//    //    pageView.ViewPage = self.tableView.defaultPage;
//    //    pageView.title = self.tableView.defaultTitle;
//    //    [cellNull.contentView addSubview:pageView];
//    //    return cellNull;
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTabelViewIndex];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTabelViewIndex];
//    }
////    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    while ([cell.contentView.subviews lastObject]!= nil) {
//        [[cell.contentView.subviews lastObject] removeFromSuperview];
//    }
//    cell.textLabel.text = _arrTableView[indexPath.row];
//    return cell;
//    return nil;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    NSIndexPath *tableIndexPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];
//    
//    [self.collectionView scrollToItemAtIndexPath:tableIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//}
//

- (DSCollectionViewIndex *)ViewIndex
{
    if (!_ViewIndex) {
        _ViewIndex = [[DSCollectionViewIndex alloc] initWithFrame:CGRectMake(Width - 30, APPDELEGATE.customTabbar.height_myNavigationBar + 44, 30, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height)];
        _ViewIndex.titleIndexes = _arrViewIndex;
        _ViewIndex.isFrameLayer = NO;
        _ViewIndex.collectionDelegate = self;
    }
    return _ViewIndex;
}
/**
 *  触摸到索引时的反应
 *
 *  @param collectionViewIndex 触发的对象
 *  @param index               触发的索引的下标
 *  @param title               触发的索引的文字
 */
-(void)collectionViewIndex:(DSCollectionViewIndex *)collectionViewIndex didselectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
    //如果有所选字母那一栏,才滑动到那一栏
    _flotageLabel.text = title;

    if ([_arrSectionData containsObject:title]) {
        NSInteger sectionIndex = [_arrSectionData indexOfObject:title];
        NSIndexPath *tableIndexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
        
        [self.collectionView scrollToItemAtIndexPath:tableIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];

    }
    
}
/**
 *  开始触摸索引
 *
 *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
 */
- (void)collectionViewIndexTouchesBegan:(DSCollectionViewIndex *)collectionViewIndex
{
    _flotageLabel.alpha = 1;
    _flotageLabel.hidden = NO;

}


/**
 *  触摸索引结束
 *
 *  @param tableViewIndex
 */
- (void)collectionViewIndexTouchesEnd:(DSCollectionViewIndex *)collectionViewIndex
{
    void (^animation)() = ^{
        _flotageLabel.alpha = 0;
    };
    
    [UIView animateWithDuration:0.4 animations:animation completion:^(BOOL finished) {
        _flotageLabel.hidden = YES;
    }];
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
