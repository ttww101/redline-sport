#import "ZBSaishiSelecterdVC.h"
#import "ZBTitleIndexView.h"
#import "ZBLiveScoreModel.h"
#import "ZBBIfenSelectedSaishiModel.h"
#import "ZBJSbifenModel.h"
@interface ZBSaishiSelecterdVC ()<ViewPagerDelegate,ViewPagerDataSource,TitleIndexViewDelegate,SelectedAllVCDelegate,SelectedJincaiVCDelegate,SelectedChupanVCDelegate,NavViewDelegate>
@property (nonatomic, strong) ZBTitleIndexView *titleView;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation ZBSaishiSelecterdVC
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
    self.navigationItem.title = @"赛事筛选";
    self.delegate =self;
    self.dataSource = self;
    self.manualLoadData = NO;
    self.scrollingLocked = NO;
    [self.view addSubview:self.titleView];
    self.currentIndex = 0;
    [self reloadData];
    [self setNavView];
    _titleView = [[ZBTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.bottomLineColor = colorDD;
    _titleView.arrData = @[@"全部",@"热门",@"初盘"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    UIPageViewControllerNavigationDirection direction;
    if (index < _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else{
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}
#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"赛事筛选";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (NSUInteger)numberOfTabsForViewPager:(ZBViewPagerController *)viewPager
{
    return 3;
}
- (UIViewController *)viewPager:(ZBViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            ZBSelectedAllVC *SelectedV  = [[ZBSelectedAllVC alloc] init];
            SelectedV.type = _type;
            SelectedV.arrData = _arrData;
            SelectedV.delegate = self;
            return SelectedV;
        }
            break;
        case 1:
        {
            ZBSelectedJincaiVC *SelectedV  = [[ZBSelectedJincaiVC alloc] init];
            SelectedV.type = _type;
            SelectedV.arrData = _arrDataJingcai;
            SelectedV.delegate = self;
            return SelectedV;
        }
            break;
        case 2:
        {
            ZBSelectedChupanVC *SelectedV  = [[ZBSelectedChupanVC alloc] init];
            SelectedV.type = _type;
            SelectedV.arrData = _arrDataChupan;
            SelectedV.delegate = self;
            return SelectedV;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)confirmSelectedChupanWithData:(NSArray *)arrSaveData
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadedBifenData"];
    NSMutableArray *arrSend = [NSMutableArray array];
    if (_type == typeSaishiSelecterdVCBifen) {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBJSbifenModel *jsmodel = [_arrBifenData objectAtIndex:i];
            ZBJSbifenModel *sendJs = [[ZBJSbifenModel alloc] init];
            sendJs.time = jsmodel.time;
            sendJs.data = [NSMutableArray array];
            [arrSend addObject:sendJs];
            for (int m = 0; m<jsmodel.data.count; m++) {
                ZBLiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                NSArray *arrletgoal = [model.letgoal componentsSeparatedByString:@","];
                NSArray *arrtotal = [model.total componentsSeparatedByString:@","];
                NSArray *arrstandard = [model.standard componentsSeparatedByString:@","];
                for (int j = 0; j<arrSaveData.count; j++) {
                    ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                    if (self.type == typeSaishiSelecterdVCTuijian ||  self.type == typeSaishiSelecterdVCInfo) {
                        if ([modelSave.name isEqualToString:model.letgoal]) {
                            [arrSend addObject:model];
                        }
                    }else{
                        if (arrletgoal.count == 3) {
                            if ([modelSave.name isEqualToString:[arrletgoal objectAtIndex:1]]) {
                                [sendJs.data addObject:model];
                                break;
                            }
                        }
                        if (arrtotal.count == 3) {
                            if ([modelSave.name isEqualToString:[arrtotal objectAtIndex:1]]) {
                                [sendJs.data addObject:model];
                                break;
                            }
                        }
                        if (arrstandard.count == 3) {
                            if ([modelSave.name isEqualToString:[arrstandard objectAtIndex:1]]) {
                                [sendJs.data addObject:model];
                                break;
                            }
                        }
                    }
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenChuPanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenChuPanSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData", nil]];
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            NSArray *arrletgoal = [model.letgoal componentsSeparatedByString:@","];
            NSArray *arrtotal = [model.total componentsSeparatedByString:@","];
            NSArray *arrstandard = [model.standard componentsSeparatedByString:@","];
            for (int j = 0; j<arrSaveData.count; j++) {
                ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (self.type == typeSaishiSelecterdVCTuijian ||  self.type == typeSaishiSelecterdVCInfo) {
                    if ([modelSave.name isEqualToString:model.letgoal]) {
                        [arrSend addObject:model];
                    }
                }else{
                    if (arrletgoal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrletgoal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrtotal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrtotal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrstandard.count == 3) {
                        if ([modelSave.name isEqualToString:[arrstandard objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenChuPanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenChuPanSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedJingCaiSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"2",@"type", nil]];
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            NSArray *arrletgoal = [model.letgoal componentsSeparatedByString:@","];
            NSArray *arrtotal = [model.total componentsSeparatedByString:@","];
            NSArray *arrstandard = [model.standard componentsSeparatedByString:@","];
            for (int j = 0; j<arrSaveData.count; j++) {
                ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (self.type == typeSaishiSelecterdVCTuijian ||  self.type == typeSaishiSelecterdVCInfo){
                    if ([modelSave.name isEqualToString:model.letgoal]) {
                        [arrSend addObject:model];
                    }
                }else{
                    if (arrletgoal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrletgoal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrtotal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrtotal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrstandard.count == 3) {
                        if ([modelSave.name isEqualToString:[arrstandard objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenChuPanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenChuPanSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedinfo object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"2",@"type", nil]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)confirmSelectedJincaiWithData:(NSArray *)arrSaveData
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadedBifenData"];
    NSMutableArray *arrSend = [NSMutableArray array];
    if (_type == typeSaishiSelecterdVCBifen) {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBJSbifenModel *jsmodel = [_arrBifenData objectAtIndex:i];
            ZBJSbifenModel *sendJs = [[ZBJSbifenModel alloc] init];
            sendJs.time = jsmodel.time;
            sendJs.data = [NSMutableArray array];
            [arrSend addObject:sendJs];
            for (int m = 0; m<jsmodel.data.count; m++) {
                ZBLiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                for (int j = 0; j<arrSaveData.count; j++) {
                    ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                    if (model.leagueId == modelSave.idId) {
                        [sendJs.data addObject:model];
                        break;
                    }
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData", nil]];
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedJingCaiSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedinfo object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)confirmSelectedAllWithData:(NSArray *)arrSaveData
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadedBifenData"];
    NSMutableArray *arrSend = [NSMutableArray array];
    if (_type == typeSaishiSelecterdVCBifen) {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBJSbifenModel *jsmodel = [_arrBifenData objectAtIndex:i];
            ZBJSbifenModel *sendJs = [[ZBJSbifenModel alloc] init];
            sendJs.time = jsmodel.time;
            sendJs.data = [NSMutableArray array];
            [arrSend addObject:sendJs];
            for (int m = 0; m<jsmodel.data.count; m++) {
                ZBLiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                for (int j = 0; j<arrSaveData.count; j++) {
                    ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                    if (model.leagueId == modelSave.idId) {
                        [sendJs.data addObject:model];
                        break;
                    }
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData", nil]];
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedJingCaiSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            ZBLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                ZBBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [ZBMethods getDocumentsPath];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedinfo object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (self.currentIndex != 0 && contentOffsetX <= Width * 2) {
        contentOffsetX += Width * self.currentIndex;
    }
}
- (void)scrollEnabled:(BOOL)enabled {
    self.scrollingLocked = !enabled;
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = enabled;
            view.bounces = enabled;
        }
    }
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self.titleView updateSelectedIndex:_currentIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
