//
//  UserViewController.m
//  GunQiuLive
//
//  Created by WQ_h on 16/3/23.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "UserViewController.h"
#import "UserOfotherCellTwo.h"
#import "UserTongjiCell.h"
#import "UserTongjiGoodPlayCell.h"
#import "TuijianDatingCell.h"
#import "TuijiandatingModel.h"
#import "UserTuijianVC.h"
#import "UserTongjiAllModel.h"

#import "TongjiVC.h"

#define cellUserViewController @"cellUserViewController"
#define cellUserViewControllerRecommand @"cellUserViewControllerRecommand"
#define cellUserTongji @"cellUserTongji"
#define cellUserTongjiGoodPlay @"cellUserTongjiGoodPlay"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UserOfotherCellTwoDelegate,UserTongjiCellDelegate>
@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserOfotherCellTwo *usercell;
//个人推荐，用的是全部里面的前十条数据
@property (nonatomic, strong) NSArray *arrRecommand;
//推荐下面的统计数据
@property (nonatomic, strong) UserTongjiAllModel *tongjiModel;


@property (nonatomic, assign) BOOL showMoreUserInfo;
@property (nonatomic, strong) NavView *nav;
@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Number=1;
    self.defaultFailure = @"暂无数据";
    [self.view addSubview:self.tableView];
    [self getCommentUserInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
}


#pragma mark -- UITableViewDataSource

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UserOfotherCellTwo class] forCellReuseIdentifier:cellUserViewController];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[TuijianDatingCell class] forCellReuseIdentifier:cellUserViewControllerRecommand];
        [_tableView registerClass:[UserTongjiCell class] forCellReuseIdentifier:cellUserTongji];
        [_tableView registerClass:[UserTongjiGoodPlayCell class] forCellReuseIdentifier:cellUserTongjiGoodPlay];

        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return _tableView;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getCommentUserInfo];

    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}

//返回单张图片
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}

//返回单张图片
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}

//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}




- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = colorF5;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = [UIColor whiteColor];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!_userModel) {
        return 0;
    }
    
    
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!_userModel) {
        return 0;
    }

    
    
 
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!_userModel) {
        return nil;
    }
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (!_userModel) {
        return 0;
    }
    if (section == 1) {
        return 40;
    }
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (!_userModel) {
        return nil;
    }

    if (section == 1) {
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
        
        UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 40)];
        if (self.Number==1) {
            lab_title.text = @"最新推荐";
        }else{
            lab_title.text = @"最新竞猜";
        }
        
        lab_title.font = font12;
        lab_title.textColor = color66;
        [header addSubview:lab_title];
        
        UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(Width - 15 - 80, 0, 80, 40)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTuijianClick)];
        [viewRight addGestureRecognizer:tap];
        viewRight.userInteractionEnabled = YES;
        [header addSubview:viewRight];
        
        UIImageView *imageRight = [[UIImageView alloc] initWithFrame:CGRectMake(80 - 8 , 0, 8, 8)];
        imageRight.center = CGPointMake(imageRight.center.x, viewRight.height/2);
        imageRight.image = [UIImage imageNamed:@"userMoreTuijian"];
        [viewRight addSubview:imageRight];
        
        
        UILabel *labRight = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 -18, 40)];
        if (self.Number==1) {
            labRight.text = @"更多推荐";
        }else{
            labRight.text = @"更多竞猜";
        }
        
        labRight.textAlignment= NSTextAlignmentRight;
        labRight.font = font12;
        labRight.textColor = color66;
        [viewRight addSubview:labRight];

        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 39, Width, 0.5)];
        viewline.backgroundColor = colorCellLine;
        [header addSubview:viewline];
        return header;
    }
    return nil;
}

- (void)didToTongjiVC
{
    
    TongjiVC *tongji = [[TongjiVC alloc] init];
    tongji.userModel = _userModel;
    tongji.hidesBottomBarWhenPushed = YES;
    if (self.Number==1) {
        tongji.tongjiType=0;
    }else{
        tongji.tongjiType=1;
    }
    
    [APPDELEGATE.customTabbar pushToViewController:tongji animated:YES];
}
- (void)btnTuijianClick
{
    UserTuijianVC *tuijian = [[UserTuijianVC alloc] init];
    tuijian.userName = _userModel.nickname;
    tuijian.userId = _userModel.idId;
    tuijian.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (!_userModel) {
        return 0;
    }

    if (section == 0) {
        return 4;
    }
    
//    if (_arrRecommand.count>10) {
//        return 10;
//    }
    return _arrRecommand.count;
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_userModel) {
        return 0;
    }

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                return [tableView fd_heightForCellWithIdentifier:cellUserViewController configuration:^(UserOfotherCellTwo * cell) {
                    cell.showMoreUserInfo = _showMoreUserInfo;
                    cell.model = _userModel;
                }];
                return 0;

            }
                break;
            case 1:
            {
                return 375;

            }
                break;
            case 2:
            {
                return 68 + 60;

            }
                break;
            case 3:
            {
                return 0;

            }
                break;

            default:
                break;
        }
    }
    return 135;
//    return [tableView fd_heightForCellWithIdentifier:cellUserViewControllerRecommand cacheByIndexPath:indexPath configuration:^(TuijianDatingCell *cell) {
//        if (_arrRecommand.count>0) {
//            cell.type = typeTuijianCellUser;
//            cell.model = [_arrRecommand objectAtIndex:indexPath.row];
//        }
//    }];

    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_userModel) {
        return [UITableViewCell new];
    }
    
    
    if (indexPath.section == 0) {
        
        
        switch (indexPath.row) {
            case 0:
            {
                UserOfotherCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellUserViewController];
                if (!cell) {
                    cell = [[UserOfotherCellTwo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserViewController];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.showMoreUserInfo = _showMoreUserInfo;
                
                cell.model = _userModel;
                cell.delegate = self;
                return cell;

            }
                break;
            case 1:
            {
                UserTongjiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserTongji];
                if (!cell) {
                    cell = [[UserTongjiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserTongji];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.model = _tongjiModel;
                cell.delegate = self;
                cell.Number=self.Number;
                return cell;

                                return [UITableViewCell new];

            }
                break;
            case 2:
            {
                UserTongjiGoodPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserTongjiGoodPlay];
                if (!cell) {
                    cell = [[UserTongjiGoodPlayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserTongjiGoodPlay];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if (_tongjiModel) {
                    cell.recent = _tongjiModel.recent;
                    cell.model = _tongjiModel.all;

                }
                return cell;

                return [UITableViewCell new];

            }
                break;
            case 3:
            {
                return [UITableViewCell new];

            }
                break;

            default:
                break;
        }
        return [UITableViewCell new];
    }else{
        
        
        TuijianDatingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserViewControllerRecommand];
        if (!cell) {
            cell = [[TuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserViewControllerRecommand];
        }
        cell.backgroundColor= [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = colorF5;
        cell.type = typeTuijianCellUser;
        if (_arrRecommand.count>0) {
            cell.model = [_arrRecommand objectAtIndex:indexPath.row];
        }
        
        return cell;
        
    }
    
    
    return [UITableViewCell new];

}



- (void)getCommentUserInfo
{
    NSString*URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_userinfo];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)self.userId] forKey:@"id"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:URLString Start:^(id requestOrignal) {
        
        if (!_userModel) {
            [LodingAnimateView showLodingView];

        }
        

        
    } End:^(id responseOrignal) {
        if (!_userModel) {
            [LodingAnimateView dissMissLoadingView];

        }


        [self.tableView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
            
            _userModel = [UserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            [self.tableView reloadData];
            
//            _usercell.model = _userModel;
            _nav.labTitle.text = [NSString stringWithFormat:@"滚球App专家%@",_userModel.nickname];

            
            [self loadTongjiData];
            [self lodaRecommandData];
            
            
            
        }else{

            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            [self.tableView reloadData];

        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        [self setNavView];
        _nav.labTitle.alpha = 1;
        _nav.bgView.alpha = 1;

        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        self.defaultFailure = errorDict;
        [self.tableView reloadData];

    }];
}

- (void)upDownBtnClick:(BOOL)selected
{
    _showMoreUserInfo = selected;
    [self.tableView reloadData];
    
}
- (void)attentionBtnClick:(UIButton *)btn
{
    [self addAtention:btn.selected];
}
- (void)navBtnClick:(NSInteger)index
{
    if (index == 1) {
        //       返回
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //    分享
    }
}


- (void)addAtention:(BOOL)attention
{
    
    if (![Methods login]) {
        [Methods toLogin];
        
        return;
    }
    //    /focusAdd 新增关注
    //    param.put("followerId", "3"); //跟随者
    //    param.put("leaderId", "5"); //被跟随者
    //
    //    /focusRemove 删除关注
    //    param.put("followerId", "3"); //跟随者
    //    param.put("leaderId", "5"); //被跟随者
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    UserModel *user = [Methods getUserModel];
    NSString *url;
    if (attention) {
        url = url_focusRemove;
    }else{
        url = url_focusAdd;
    }
    
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)user.idId] forKey:@"followerId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_userId] forKey:@"leaderId"];
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                
                if (attention) {
                    _userModel.followerCount = _userModel.followerCount -1;
                    user.focusCount = user.focusCount -1;
                }else{
                    _userModel.followerCount = _userModel.followerCount +1;
                    user.focusCount = user.focusCount +1;
                    
                }
                _userModel.focused = !_userModel.focused;
                [Methods updateUsetModel:user];
                
            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:attention? @"取消关注失败":@"关注失败"];
            }
        }else
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:attention? @"取消关注失败":@"关注失败"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:attention? @"取消关注失败":@"关注失败"];
        
    }];
}






- (void)lodaRecommandData
{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)self.userId] forKey:@"userId"];
    [parameter setObject:[NSString stringWithFormat:@"%d",0] forKey:@"limitStart"];
    [parameter setObject:[NSString stringWithFormat:@"%d",20] forKey:@"limitNum"];
    NSString*URLString;
    if (self.Number==1) {
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_recommendlistUser];
        [parameter setObject:[NSString stringWithFormat:@"%d",0] forKey:@"oddstype"];
    }else{
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_quizmyQuizList];
        [parameter setObject:[NSString stringWithFormat:@"%d",0] forKey:@"playtype"];
    }
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:URLString Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrRecommand = [NSArray arrayWithArray:[TuijiandatingModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]] ;
            
            [self.tableView reloadData];
        }else{
            
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];
}



- (void)loadTongjiData
{
    NSString*URLString;
    if (self.Number==1) {
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ucenterstatis];
    }else{
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_quizmyQuizIndex];
        
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userId] forKey:@"userId"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:URLString Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {

    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {


            _tongjiModel = [UserTongjiAllModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            [self.tableView reloadData];

        }else{
            
            
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];
}





#pragma mark -- setnavView
- (void)setNavView
{
    _nav = [[NavView alloc] init];
    _nav.delegate = self;
    _nav.labTitle.text = @"个人中心";
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@"usercentershare"] forState:UIControlStateNormal];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@"usercentershare"] forState:UIControlStateHighlighted];
    [self.view addSubview:_nav];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (_userModel) {
//        _nav.bgView.alpha = scrollView.contentOffset.y*1.5/100 >1 ? 1:scrollView.contentOffset.y*1.5/100;
//        _nav.labTitle.alpha = scrollView.contentOffset.y*1.5/100 >1 ? 1:scrollView.contentOffset.y*1.5/100;
//    }else{
//    
//        _nav.bgView.alpha = 1;
//        _nav.labTitle.alpha = 1;
//    }
//    


}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
    
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            
            switch (platformType) {
                case UMSocialPlatformType_Sina: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装新浪客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_WechatSession: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_WechatTimeLine: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatTimeLine]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_QQ: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_Qzone: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Qzone]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                    
                    
                    
                default:
                    break;
            }
            
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"分析师%@详情",_userModel.nickname] descr:@"滚球体育】— 知道更多，赢得更多!通过大数据分析技术及独有的数据算法，帮助彩民提供全方位的竞彩足球比分直播、情报资讯、足彩大数据分析、竞彩投注方案和投注分析等服务。" thumImage:@"http://mobile.gunqiu.com/share/v2.2/img/applogo.png"];
            //设置网页地址
            shareObject.webpageUrl = [NSString stringWithFormat:@"http://mobile.gunqiu.com/share/v2.2/chengji.html?id=%zi",_userId];
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:APPDELEGATE.customTabbar completion:^(id data, NSError *error) {
                if (error) {
                   
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                }
            }];
        }];
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
