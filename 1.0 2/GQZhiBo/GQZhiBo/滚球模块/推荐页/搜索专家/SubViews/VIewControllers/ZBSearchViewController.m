//
//  ZBSearchViewController.m
//  GQapp
//
//  Created by WQ_h on 16/8/8.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBSearchViewController.h"
#import "ZBTuijiandatingModel.h"
#import "ZBUserlistModel.h"

#import "ZBSearchVCZhujiaCell.h"
@interface ZBSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;

//tableView
@property (strong, nonatomic)  UITableView *tableView;

//数据源。历史搜索
@property (strong,nonatomic) NSMutableArray  *dataList;
//搜索时显示的历史信息信息
@property (strong,nonatomic) NSMutableArray  *searchList;
//推荐专家
@property (strong,nonatomic) NSArray  *arrZhunjia;

//搜索的结果
@property (nonatomic, strong) NSArray *arrData;
@end

@implementation ZBSearchViewController
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [_searchBar becomeFirstResponder];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadHotZhuanjia];
    
    _dataList = [NSMutableArray array];
    _searchList = [NSMutableArray array];
    [_dataList addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:[self getLocalPath]]];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar,Width ,Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, Width, APPDELEGATE.customTabbar.height_myNavigationBar)];
    
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.barTintColor = redcolor;
    //光标颜色
    _searchBar.tintColor = [UIColor blackColor];
//    _searchBar.backgroundImage = [UIImage imageNamed:@"red"];
    
    // 设置搜索栏下部背景图片
    _searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"white"];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索专家";

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
    
    [self.view addSubview:_tableView];
    self.view.backgroundColor = redcolor;
    [self setNavView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow) name:UIKeyboardWillShowNotification object:nil];
}
- (void)KeyboardShow
{
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", _searchBar.text];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];

}
#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [nav.btnRight setTitle:@"取消" forState:UIControlStateNormal];
    [nav.btnRight setTitle:@"取消" forState:UIControlStateHighlighted];
    nav.btnRight.titleLabel.font = font14;
    _searchBar.frame = CGRectMake(0, nav.btnLeft.y, Width - nav.btnLeft.width, nav.btnLeft.height);
    [nav addSubview:_searchBar];
    [self.view addSubview:nav];
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



////产生3个随机字母
//- (NSString *)shuffledAlphabet {
//    
//    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
//    
//    NSString *strTest = [[NSString alloc]init];
//    for (int i=0; i<3; i++) {
//        int x = arc4random() % 25;
//        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
//    }
//    
//    return strTest;
//    
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_searchBar.isFirstResponder) {
        return 1;
    }else{
        return 2;
    }
    
    return 0;
}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchBar.isFirstResponder) {
        return [self.searchList count];
    }else{
        if (section == 0) {
            return [self.arrZhunjia count];

        }else{
            if (self.dataList.count == 0) {
                return 1;
            }
            return [self.dataList count];

        }
    }
    return 0;
}


//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_searchBar.isFirstResponder) {
        static NSString *acell = @"acell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
        }
        while ([cell.contentView.subviews lastObject]!= nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 20, 20)];
        img.image = [UIImage imageNamed:@"ic_mer_time"];
        [cell.contentView addSubview:img];
        
        UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(img.right + 9,12, 200, 20)];
        
        labName.text = self.searchList[indexPath.row];
        
        labName.textColor = color52;
        labName.font = font14;
        [cell.contentView addSubview:labName];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 42, Width - 20, 0.5)];
        lineView.backgroundColor = colorCellLine;
        [cell.contentView addSubview:lineView];
        return cell;

        
    }else{
    
    if (indexPath.section == 0) {
        static NSString *flag=@"cell";
        ZBSearchVCZhujiaCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZBSearchVCZhujiaCell" owner:nil options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = [self.arrZhunjia objectAtIndex:indexPath.row];
        if (indexPath.row == self.arrZhunjia.count -1) {
            cell.viewBottom.backgroundColor = [UIColor whiteColor];
        }else{
            cell.viewBottom.backgroundColor = colorCellLine;

        }
        return cell;
    }
    
    
    
    static NSString *acell = @"acell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
        while ([cell.contentView.subviews lastObject]!= nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 20, 20)];
    [cell.contentView addSubview:img];
    
    UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(img.right + 9,12, Width - (img.right + 9)*2, 20)];
    
    
    labName.textColor = color52;
    labName.font = font14;
    [cell.contentView addSubview:labName];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, Width - 0, 0.5)];
    lineView.backgroundColor = colorCellLine;
    
    
    if (self.dataList.count == 0) {
        img.image = [UIImage imageNamed:@"white"];
        labName.text = @"暂无搜索记录";
        labName.textAlignment = NSTextAlignmentCenter;

    }else{
        img.image = [UIImage imageNamed:@"ic_mer_time"];
        labName.text = self.dataList[indexPath.row];
        labName.textAlignment = NSTextAlignmentLeft;

    }

    
    [cell.contentView addSubview:lineView];
    return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_searchBar.isFirstResponder) {
        return 48;
    }
    
    if (indexPath.section == 0) {
        return 80;
    }
    return 48;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_searchBar.isFirstResponder) {
    
        if (indexPath.section == 0) {

            ZBUserlistModel *user = [_arrZhunjia objectAtIndex:indexPath.row];
            
            if (user.userid == 1) {
                return;
            }
            ZBUserViewController *userVC = [[ZBUserViewController alloc] init];
            userVC.userId = user.userid;
            userVC.userName = user.nickname;
            userVC.userPic = user.pic;
            userVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
            
            
        }else if (indexPath.section == 1){

            if (self.dataList.count == 0) {
                return;
            }
            
            [self searchTuijianInfoWithName:self.dataList[indexPath.row]];

        }
        
    }else{
    

        [self searchTuijianInfoWithName:self.searchList[indexPath.row]];
    
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_searchBar.isFirstResponder) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    bgView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 18, 8, 8)];
    lineView.backgroundColor =colorFBAF04;
    [bgView addSubview:lineView];
    
    UILabel *labHeader = [[UILabel alloc] initWithFrame:CGRectMake(lineView.right + 10, 12, Width, 20)];
    labHeader.text =section == 0? @"热门专家" : @"历史记录";
    labHeader.textColor = color33;
    labHeader.font = font14;
    [bgView addSubview:labHeader];
    
    UIView *lineViewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Width, 0.5)];
    lineViewBottom.backgroundColor =colorCellLine;
    [bgView addSubview:lineViewBottom];

    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchBar.isFirstResponder) {
        return 0;
    }
    return 44;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (!_searchBar.isFirstResponder) {
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 10)];
            footer.backgroundColor = colorTableViewBackgroundColor;
            return footer;

        }

    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (!_searchBar.isFirstResponder) {
            
            return 10;
        }
    }
    return 0;
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes
{
    
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
{
    
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
//搜索按钮
    [self searchTuijianInfoWithName:searchBar.text];
//    _searchBar.showsCancelButton = YES;
    [_searchBar resignFirstResponder];

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



























- (void)searchTuijianInfoWithName:(NSString *)nickName
{
    NSMutableDictionary *parmater = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parmater setObject:nickName forKey:@"nickname"];
    [parmater setObject:@"14" forKey:@"flag"];
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parmater PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
//        _searchBar.showsCancelButton = YES;

        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrZhunjia = [NSArray arrayWithArray:[ZBUserlistModel  arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [_searchBar resignFirstResponder];
            [self.tableView reloadData];

            
            

            if (_arrZhunjia.count > 0) {
                if (![self.dataList containsObject:nickName]) {
                    
                    if (self.dataList.count>6) {
                        [self.dataList removeLastObject];
                    }
                    [self.dataList addObject:nickName];
                    [self.dataList writeToFile:[self getLocalPath] atomically:YES];
                }
                

            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有搜索结果"];

            }
            
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有搜索结果"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有搜索结果"];

    }];
    

}
- (void)loadHotZhuanjia
{
    NSMutableDictionary *parmater = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parmater PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_speciallist_hot] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrZhunjia = [NSArray arrayWithArray:[ZBUserlistModel  arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [self.tableView reloadData];
            
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有搜索结果"];
        
    }];
}


- (NSString *)getLocalPath{
    
    NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    return  [documentsPath stringByAppendingPathComponent:@"searchHistoryArray.plist"];

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
