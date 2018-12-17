#import "ZBSelectedJincaiVC.h"
#import "ZBAllSelectedView.h"
#import "ZBBIfenSelectedSaishiModel.h"
#import "ZBSelectedCCell.h"
#define cellCollectioneSlectedJincai @"cellCollectioneSlectedJincai"
#define headerCollectioneSlectedJincai @"headerCollectioneSlectedJincai"
#define cellCollectionHeight (29)
#define cellCollectionWidth ((Width - 25 - 20 - 30)/3)
@interface ZBSelectedJincaiVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AllSelectedViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZBAllSelectedView *allselectedV;
@property (nonatomic, assign) BOOL allBtnIsSelected;

@property (nonatomic, strong) NSMutableArray<ZBBIfenSelectedSaishiModel *> *dataList;


@end
@implementation ZBSelectedJincaiVC

- (void)loadData {
    [ZBLodingAnimateView showLodingView];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.filterParameters) forKey:@"filter"];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.timeline) forKey:@"timeline"];
    [parameter setValue:self.tab forKey:@"tab"];
//    NSString *path = [NSString stringWithFormat:@"http://120.55.30.173:8809%@",url_bifen_filterAll];
     NSString *path = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_filterAll];
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:path Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal[@"data"];
            FilterModel *model = [FilterModel yy_modelWithDictionary:dic];
            self.dataList = [model.items mutableCopy];
            [self.collectionView reloadData];
            [self checkoutAllSelected];
        } else {

        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showErrorWithStatus:errorDict];
        [ZBLodingAnimateView dissMissLoadingView];
    }];
    
}

- (void)checkoutAllSelected {
    BOOL isAllSelected = true;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        ZBBIfenSelectedSaishiModel *bifenmodel = self.dataList[i];
        if (!bifenmodel.isSelected) {
            isAllSelected = false;
            break;
        }
    }
    _allselectedV.btnAll.selected = isAllSelected;
}

#pragma mark - Lazy Load

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;;
}


#pragma mark - ************   ************

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.allselectedV];
    self.allselectedV.btnAll.selected = _allBtnIsSelected;
    [self.view addSubview:self.collectionView];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        [self.dataList enumerateObjectsUsingBlock:^(ZBBIfenSelectedSaishiModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              obj.isSelected = true;
        }];
        [self.collectionView reloadData];
    }else if (index == 1) {
        [self.dataList enumerateObjectsUsingBlock:^(ZBBIfenSelectedSaishiModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = false;
        }];
        [self.collectionView reloadData];
    }else if (index == 2) {
        if (_allselectedV.btnAll.selected && [self.timeline isEqualToString:@"live"]) {
            [_delegate confirmSelectedJincaiWithData:nil];
        } else {
            if (_delegate && [_delegate respondsToSelector:@selector(confirmSelectedJincaiWithData:)]) {
                NSMutableArray *arrMemory = [NSMutableArray arrayWithArray:self.dataList];
                NSMutableArray *arrSend = [NSMutableArray array];
                for (int i = 0 ;i<arrMemory.count; i++) {
                    ZBBIfenSelectedSaishiModel *model = [arrMemory objectAtIndex:i];
                    if (model.isSelected) {
                        [arrSend addObject:model];
                    }
                }
                [_delegate confirmSelectedJincaiWithData:arrSend];
            }
        }
    }
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(Width, 0);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.collectionView];
        [self.view bringSubviewToFront:self.collectionView];
        [self.collectionView registerClass:[ZBSelectedCCell class] forCellWithReuseIdentifier:cellCollectioneSlectedJincai];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedJincai];
    }
    return _collectionView;
}
#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBSelectedCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellCollectioneSlectedJincai forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    else{
    }
    ZBBIfenSelectedSaishiModel *model = [self.dataList objectAtIndex:indexPath.row];
    cell.cellSize = CGSizeMake(cellCollectionWidth, cellCollectionHeight);
    cell.model = model;
    cell.selected = model.isSelected;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedJincai forIndexPath:indexPath];
    headerView.backgroundColor = colorTableViewBackgroundColor;
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ZBBIfenSelectedSaishiModel *model = [self.dataList objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [_allselectedV changeBtnSelectedState:model.isSelected];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
    [self checkoutAllSelected];
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
@end
