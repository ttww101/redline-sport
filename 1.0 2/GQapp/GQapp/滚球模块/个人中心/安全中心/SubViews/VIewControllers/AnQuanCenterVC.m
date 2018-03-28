//
//  AnQuanCenterVC.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/4/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "AnQuanCenterVC.h"
#import "RealNameCerVC.h"
#import "ChangePassWordVC.h"
#import "MyProfileVC.h"
#import "BangAccountVC.h"
@interface AnQuanCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;



@end

@implementation AnQuanCenterVC


- (void)viewWillAppear:(BOOL)animated{
    _model = [Methods getUserModel];
    [self.tableView reloadData];
     [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
//- (void)setModel:(UserModel *)model{
//    _model = model;
//    [self.tableView reloadData];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark -- setnavView
- (void)setNavView{
        NavView *nav = [[NavView alloc] init];
        nav.delegate = self;
        nav.labTitle.text = @"安全中心";
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
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //2
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 3;
        }
            break;
//        case 1:
//        {
//            return 1;
//        }
//            break;
//            
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 40, 44)];
    lab.textColor = color33;
    lab.font = font16;
    [cell.contentView addSubview:lab];
    
    UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 0, 7, 14)];
    imageMore.center = CGPointMake(imageMore.center.x, lab.center.y);
    imageMore.image = [UIImage imageNamed:@"meRight"];
    [cell.contentView addSubview:imageMore];
    
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(20, 43, Width - 20, 0.5)];
    viewline.backgroundColor = colorCellLine;
    [cell.contentView addSubview:viewline];
    
    UILabel *labStr = [[UILabel alloc] init];
    labStr.font = font12;
    labStr.textAlignment = NSTextAlignmentRight;
    labStr.textColor = color99;
    [cell.contentView addSubview:labStr];
    [labStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageMore.mas_left).offset(-15);
        make.top.mas_equalTo(cell.contentView.mas_top);
        make.height.mas_offset(44);
        make.width.mas_offset(50);
    }];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                lab.text = @"实名认证";
                if (self.model.autonym == 1) {
                    labStr.text = @"已认证";
                }else{
                    labStr.text = @"未认证";
                }
               
            }
                break;
            case 1:
            {
                lab.text = @"账户绑定";
                if (_model.mobile.length > 0) {
                    labStr.text = @"修改";
                }else{
                    labStr.text = @"绑定";
                }
            }
                break;
            case 2:
            {
                lab.text = @"修改密码";
                labStr.text = @"修改";
                viewline.backgroundColor = [UIColor clearColor];
            }
                break;
                
            default:
                break;
        }
        
    }
//    else{
//        lab.text = @"我的资料";
//        labStr.text = @"修改";
//        viewline.backgroundColor = [UIColor clearColor];
//        
//    }
//    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                RealNameCerVC *realNameVC = [[RealNameCerVC alloc] init];
                realNameVC.type = 0;
                realNameVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:realNameVC animated:YES];
            }
                
                break;
            case 1:{
                
                BangAccountVC *bangVC = [[BangAccountVC alloc] init];
                bangVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:bangVC animated:YES];
            }
                
                break;
            case 2:{
                
                ChangePassWordVC *psssWordVC = [[ChangePassWordVC alloc] init];
                psssWordVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:psssWordVC animated:YES];
                
            }
                
                break;
                
            default:
                break;
        }
    }
//    else{
//        MyProfileVC *myProfile = [[MyProfileVC alloc] init];
//        myProfile.hidesBottomBarWhenPushed = YES;
//        [APPDELEGATE.customTabbar pushToViewController:myProfile animated:YES];
//        
//    }
    
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
