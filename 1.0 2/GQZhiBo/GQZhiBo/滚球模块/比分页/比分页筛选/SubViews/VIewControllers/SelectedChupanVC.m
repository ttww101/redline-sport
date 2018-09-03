//
//  SelectedChupanVC.m
//  GQapp
//
//  Created by WQ_h on 16/8/29.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "SelectedChupanVC.h"
#import "AllSelectedView.h"
#import "BIfenSelectedSaishiModel.h"
#import "SelectedCCell.h"
#define cellCollectioneSlectedChupan @"cellCollectioneSlectedChupan"
#define headerCollectioneSlectedChupan @"cellCollectioneSlectedChupan"
#define cellCollectionHeight (29)
#define cellCollectionWidth ((Width - 30 - 10)/2)

@interface SelectedChupanVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AllSelectedViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
//底部的全选按钮
@property (nonatomic, strong) AllSelectedView *allselectedV;
// 区头的数据
@property (nonatomic, strong) NSMutableArray *arrSectionData;
//cell的数据,大数组里面包含的是小数组
@property (nonatomic, strong) NSMutableArray *arrItemData;
//记录全选按钮是否要被全部选中
@property (nonatomic, assign) BOOL allBtnIsSelected;


@end

@implementation SelectedChupanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.allselectedV];
    self.allselectedV.btnAll.selected = _allBtnIsSelected;

    [self.view addSubview:self.collectionView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
        
        
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
        
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
                if ([model.name isEqualToString:Savemodel.name]) {
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
        if (_delegate && [_delegate respondsToSelector:@selector(confirmSelectedChupanWithData:)]) {
            
            
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
//            NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
//            [NSKeyedArchiver archiveRootObject:arrSend toFile:arrSaveBifenAllSelected];
            
            [_delegate confirmSelectedChupanWithData:arrSend];
            
            
            
        }
    }
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //区头的高度
        layout.headerReferenceSize = CGSizeMake(Width, 0);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.collectionView];
        [self.view bringSubviewToFront:self.collectionView];
        [self.collectionView registerClass:[SelectedCCell class] forCellWithReuseIdentifier:cellCollectioneSlectedChupan];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedChupan];
    }
    return _collectionView;
}

#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"%ld",_arrSectionData.count);
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
    SelectedCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellCollectioneSlectedChupan forIndexPath:indexPath];
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
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedChupan forIndexPath:indexPath];
    headerView.backgroundColor = colorTableViewBackgroundColor;
//    [headerView removeAllSubViews];
//    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 20)];
//    labTitle.textColor = grayColor34;
//    labTitle.font = font13;
//    labTitle.text = _arrSectionData[indexPath.section];
//    [headerView addSubview:labTitle];
    
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
    return UIEdgeInsetsMake(15, 12, 12, 15);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
