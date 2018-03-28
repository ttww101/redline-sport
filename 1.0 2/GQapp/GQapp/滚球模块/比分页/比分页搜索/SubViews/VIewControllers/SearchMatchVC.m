//
//  SearchMatchVC.m
//  GQapp
//
//  Created by WQ on 2017/5/11.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define  cellSearchMatchVC @"cellSearchMatchVC"
#import "SaiTableViewCell.h"
#import "LiveScoreModel.h"
#import "JSbifenModel.h"
#import "SearchMatchVC.h"

@interface SearchMatchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation SearchMatchVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self.view addSubview:self.tableView];

}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [nav.btnRight setTitle:@"取消" forState:UIControlStateNormal];
    [nav.btnRight setTitle:@"取消" forState:UIControlStateHighlighted];
    nav.btnRight.titleLabel.font = font14;
    [self.view addSubview:nav];
    
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, Width, 44)];
    
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.barTintColor = redcolor;
    _searchBar.tintColor = [UIColor blackColor];
    _searchBar.backgroundImage = [UIImage imageNamed:@"red"];
    
    // 设置搜索栏下部背景图片
    _searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"white"];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索比赛";
    
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.font = font14;
    if (searchField) {
        
        [searchField setBackgroundColor:[UIColor whiteColor]];
        
        searchField.layer.cornerRadius = 5.0f;
        
        searchField.layer.borderColor = redcolor.CGColor;
        
        searchField.layer.borderWidth = 1;
        
        searchField.layer.masksToBounds = YES;
        
    }
    
    
    //显示取消按钮
    //    _searchBar.showsCancelButton = YES;

    _searchBar.frame = CGRectMake(0, nav.btnLeft.y, Width - nav.btnLeft.width, nav.btnLeft.height);
    [nav addSubview:_searchBar];

}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        
    }else if(index == 2){
        //right
        [self.navigationController popViewControllerAnimated:YES];

        
    }
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes
{
    
    
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
//    if (self.searchList!= nil) {
//        [self.searchList removeAllObjects];
//    }
//    //过滤数据
//    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
//    //刷新表格
//    [self.tableView reloadData];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
{
    
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
    //搜索按钮
    [self searchMatchWithName:searchBar.text];
    
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; // called when bookmark button pressed
{
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
{
    //取消按钮
    [self.navigationController popViewControllerAnimated:YES];
    [_searchBar resignFirstResponder];
    
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // called when search results button pressed
{
    
}


#pragma mark -- UITableViewDataSource

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[SaiTableViewCell class] forCellReuseIdentifier:cellSearchMatchVC];

        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JSbifenModel *model = [_arrData objectAtIndex:section];
    
    return model.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveScoreModel *model;
    if (_arrData.count > 0) {
        
        JSbifenModel *jsmodel = [_arrData objectAtIndex:indexPath.section];
        
        model = [jsmodel.data objectAtIndex:indexPath.row];
    }
    if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
        return 108;
    }
    return 80;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSearchMatchVC];
    if (!cell) {
        cell = [[SaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSearchMatchVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_arrData.count >0) {
        
        JSbifenModel *model = [_arrData objectAtIndex:indexPath.section];
        
        
        cell.ScoreModel = [model.data objectAtIndex:indexPath.row];
    }
    
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    
    
    
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}



- (void)searchMatchWithName:(NSString *)searchStr
{
    
    int count = 0;
    _arrData = [NSMutableArray array];
    for (int i = 0; i< _arrAlldata.count; i++) {
        JSbifenModel *jsmodel = [_arrAlldata objectAtIndex:i];
        
        //创建一个和比分数据一样但是为空的model，用来存放筛选过后的数据
        JSbifenModel *sendJs = [[JSbifenModel alloc] init];
        sendJs.time = jsmodel.time;
        sendJs.data = [NSMutableArray array];
        [_arrData addObject:sendJs];
        
        
        for (int m = 0; m<jsmodel.data.count; m++) {
            
            LiveScoreModel *model = [jsmodel.data objectAtIndex:m];
            if ([model.hometeam containsString:searchStr] ||[model.guestteam containsString:searchStr]||[model.league containsString:searchStr] )
            {
                [sendJs.data addObject:model];
                count ++;
            }
            
            
        }
    }
    
    if (count == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"未找到比赛"];
    }else{
        [self.tableView reloadData];
        [_searchBar resignFirstResponder];

    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
