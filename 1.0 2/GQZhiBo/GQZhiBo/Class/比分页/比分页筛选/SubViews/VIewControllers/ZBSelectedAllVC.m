#import "ZBSelectedAllVC.h"
#import "ZBAllSelectedView.h"
#import "ZBDSCollectionViewIndex.h"
#import "ZBBIfenSelectedSaishiModel.h"
#import "ZBSelectedCCell.h"
#define CollectionCellSelectedAllVC @"CollectionCellSelectedAllVC"
#define CollectionHeaderSelectedAllVC @"CollectionHeaderSelectedAllVC"
#define cellTabelViewIndex @"cellTabelViewIndex"
#define cellCollectionHeight (29)
#define cellCollectionWidth ((Width - 25 - 20 - 30)/3)
@interface ZBSelectedAllVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AllSelectedViewDelegate,DSCollectionViewIndexDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZBAllSelectedView *allselectedV;
@property (nonatomic, strong) NSArray *arrViewIndex;
@property (nonatomic, strong) ZBDSCollectionViewIndex *ViewIndex;
@property (nonatomic, strong) NSMutableArray *arrSectionData;
@property (nonatomic, strong) NSMutableArray *arrItemData;
@property (nonatomic, assign) BOOL allBtnIsSelected;
@property (nonatomic, strong) UILabel *flotageLabel;
@end
@implementation ZBSelectedAllVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _arrViewIndex = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self.view addSubview:self.allselectedV];
    self.allselectedV.btnAll.selected = _allBtnIsSelected;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.ViewIndex];
    [self.view addSubview:self.flotageLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    NSString *documentPath = [ZBMethods getDocumentsPath];
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
        ZBBIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
            model.isSelected = NO;
            _allBtnIsSelected = NO;
        }else{
            if (arrsaveSaishi.count == 0) {
                model.isSelected = NO;
                _allBtnIsSelected = NO;
            }else{
            model.isSelected = NO;
            for (int j = 0; j<arrsaveSaishi.count; j++) {
                ZBBIfenSelectedSaishiModel *Savemodel = [arrsaveSaishi objectAtIndex:j];
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
            [_arrSectionData addObject:model.index];
            NSMutableArray *arrItem = [NSMutableArray array];
            [arrItem addObject:model];
            [_arrItemData addObject:arrItem];
        }else{
            NSInteger index = [_arrSectionData indexOfObject:model.index];
            NSMutableArray *arrItem = [_arrItemData objectAtIndex:index];
            [arrItem addObject:model];
        }
    }
}
- (ZBAllSelectedView *)allselectedV
{
    if (!_allselectedV) {
        _allselectedV = [[ZBAllSelectedView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 44)];
        _allselectedV.delegate = self;
    }
    return _allselectedV;
}
- (void)didSelectedAtBtnIndex:(NSInteger)index whtherSelected:(BOOL)selected
{
    if (index == 0) {
        for (int i = 0; i<_arrData.count; i++) {
            ZBBIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
            model.isSelected = YES;
        }
        [self.collectionView reloadData];
    }else if (index == 1) {
        for (int i = 0; i<_arrData.count; i++) {
            ZBBIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
            model.isSelected = NO;
        }
        [self.collectionView reloadData];
    }else if (index == 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(confirmSelectedAllWithData:)]) {
            NSMutableArray *arrMemory = [NSMutableArray arrayWithArray:_arrData];
            NSMutableArray *arrSend = [NSMutableArray array];
            for (int i = 0 ;i<arrMemory.count; i++) {
                ZBBIfenSelectedSaishiModel *model = [arrMemory objectAtIndex:i];
                if (model.isSelected) {
                    [arrSend addObject:model];
                }
            }
            [_delegate confirmSelectedAllWithData:arrSend];
        }
    }
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(Width, 24);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZBSelectedCCell class] forCellWithReuseIdentifier:CollectionCellSelectedAllVC];
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
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBSelectedCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellSelectedAllVC forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    else{
    }
    NSMutableArray *arr = [_arrItemData objectAtIndex:indexPath.section];
    ZBBIfenSelectedSaishiModel *model = [arr objectAtIndex:indexPath.row];
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
    ZBBIfenSelectedSaishiModel *model = [arr objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [_allselectedV changeBtnSelectedState:model.isSelected];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
}
#pragma mark --  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellCollectionWidth,cellCollectionHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 12, 12, 30);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}
- (ZBDSCollectionViewIndex *)ViewIndex
{
    if (!_ViewIndex) {
        _ViewIndex = [[ZBDSCollectionViewIndex alloc] initWithFrame:CGRectMake(Width - 30, APPDELEGATE.customTabbar.height_myNavigationBar + 44, 30, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height)];
        _ViewIndex.titleIndexes = _arrViewIndex;
        _ViewIndex.isFrameLayer = NO;
        _ViewIndex.collectionDelegate = self;
    }
    return _ViewIndex;
}
-(void)collectionViewIndex:(ZBDSCollectionViewIndex *)collectionViewIndex didselectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
    _flotageLabel.text = title;
    if ([_arrSectionData containsObject:title]) {
        NSInteger sectionIndex = [_arrSectionData indexOfObject:title];
        NSIndexPath *tableIndexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
        [self.collectionView scrollToItemAtIndexPath:tableIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }
}
- (void)collectionViewIndexTouchesBegan:(ZBDSCollectionViewIndex *)collectionViewIndex
{
    _flotageLabel.alpha = 1;
    _flotageLabel.hidden = NO;
}
- (void)collectionViewIndexTouchesEnd:(ZBDSCollectionViewIndex *)collectionViewIndex
{
    void (^animation)() = ^{
        _flotageLabel.alpha = 0;
    };
    [UIView animateWithDuration:0.4 animations:animation completion:^(BOOL finished) {
        _flotageLabel.hidden = YES;
    }];
}
@end
