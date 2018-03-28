//
//  Dan_StringGuanVC.m
//  GQapp
//
//  Created by 叶忠阳 on 16/8/25.
//  Copyright © 2016年 GQXX. All rights reserved.
//  单关  串关

#import "Dan_StringGuanVC.h"
#import "Dan_StringGuanModel.h"
#import "Dan_StringMatchsModel.h"


#import "LiveScoreModel.h"

#import "SaishiSelecterdVC.h"
#import "BIfenSelectedSaishiModel.h"


#import "RelRecNewVC.h"




@interface Dan_StringGuanVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong)UITableView *tabView;
@property (nonatomic, retain)UIView *typeView;//按开赛时间，按比赛类型VIew
@property (nonatomic, strong)UIButton *btnViewOne;
@property (nonatomic, strong)UIButton *btnViewTwo;
@property (nonatomic, retain)NSMutableArray *arrSectionBtn;
@property (nonatomic, retain)NSMutableArray *arrSection;

@property (nonatomic, retain)NSMutableArray *arrSelectCell;//点击cell的按钮
@property (nonatomic, retain)NSIndexPath * indexPath;//记录点击的cell
@property (nonatomic, retain)NSIndexPath *cureesIndexPath;//记录之前选的indepath
@property (nonatomic, assign)NSInteger btntag;//记住选择的按钮
@property (nonatomic, retain)NSMutableArray *arrData;//数据,
@property (nonatomic, retain)NSMutableArray *arrDataTime;//这个是按时间
@property (nonatomic, retain)NSMutableArray *arrDataLeageue;//这个是按赛事

@property (nonatomic, retain)NSArray *arrDataAll;
@property (nonatomic, retain)NSMutableArray *arrDataShaiShiAll;
@property (nonatomic, retain)NSMutableArray *arrDataShaiShiOdds;
@property (nonatomic, retain)NSMutableArray *arrDataShaiShiJiCai;

@property (nonatomic, retain)NSMutableArray *arrLiveScoreModelAll;



@property (nonatomic, assign)NSInteger type;
@property (nonatomic, strong)NSString *urlTypeStr;

//单关只能选择一场
@property (nonatomic, retain)NSMutableArray *arrSelectedMathch;
@property (nonatomic, strong)UIView *lineVinew;//赛事 时间的分割线
@property (nonatomic, strong)UIView *saiShiChoeesView;
@property (nonatomic, retain)NSMutableArray *arrLeagedChooes;//保存已经筛选出来的
;

@property (nonatomic, assign)NSInteger newTypeNum;//选择的玩法
@property (nonatomic, assign)NSInteger oddsNum;//选择的赔率
@property (nonatomic, strong)Dan_StringMatchsModel *selectModel;//选中的model
@property (nonatomic, strong)UIButton *saiXuanBtn;





@end

@implementation Dan_StringGuanVC

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    
//    if (_type == 0) {
//        self.urlTypeStr = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,[NSString stringWithFormat:@"/duizhen/%@/time.json",_jsonStr] ];
//        
//    }else{
//        self.urlTypeStr = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,[NSString stringWithFormat:@"/duizhen/%@/league.json",_jsonStr]];
//
//    }
//    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:self.urlTypeStr Start:^(id requestOrignal) {
//        
//    } End:^(id responseOrignal) {
//    } Success:^(id responseResult, id responseOrignal) {
//        
//        
//        
//        self.arrDataAll = [Dan_StringGuanModel arrayOfEntitiesFromArray:responseOrignal];
//        
//        
//        
//        
//    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        NSLog(@"%@",error);
//    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavView];

    self.defaultFailure = @"";
    self.flag = 0;
    self.dan_Chuan = 0;
    _arrSectionBtn = [[NSMutableArray alloc] initWithCapacity:0];
    _arrSection = [[NSMutableArray alloc] initWithCapacity:0];
    self.view.backgroundColor = ColorWithRGBA(238, 238, 238, 1);
    _type = 0;
    
    self.urlTypeStr = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,[NSString stringWithFormat:@"/duizhen/%@/time.json",_jsonStr]];
    _btntag = 10;
//    [self.view addSubview:self.typeView];
//    [self.typeView addSubview:self.btnViewOne];
//    [self.typeView addSubview:self.lineVinew];
//    [self.typeView addSubview:self.btnViewTwo];
    [self.view addSubview:self.tabView];

    [self getdataWithtype:loadDataFirst];
    
    
    
    //筛选之后重新加载视图时的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateByselectedsaishi:) name:NotificationupdateByselectedJingCaiSaishi object:nil];
}
#pragma mark -- setnavView
- (void)setNavView{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"发布推荐";
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
- (NSArray *)arrDataAll{
    if (!_arrDataAll) {
        _arrDataAll = [[NSArray alloc] init];
    }
    return _arrDataAll;
}

- (void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getdataWithtype:(loadDataType)type{
    
    
    if (type == loadDataFirst || type == loadDataHeaderRefesh) {
        
    }else{
        
        
        if (_type == 0 && _arrData.count != 0 && _arrDataTime.count != 0) {
            _arrData = _arrDataTime;
            self.arrDataAll = _arrDataTime;
            for (int i = 0; i < _arrData.count; i ++) {
                if (i == 0 && self.type == 0) {
                    [_arrSection addObject:@(1)];
                }else{
                    [_arrSection addObject:@(0)];
                }
                
                Dan_StringGuanModel *model = _arrData[i];
                NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
                for (int j = 0; j < model.matchs.count; j++) {
                    [arr addObject:@(0)];
                    
                    Dan_StringMatchsModel *dan_StringModel = model.matchs[j];
                    LiveScoreModel *liveScoreModel = [[LiveScoreModel alloc] init];
                    liveScoreModel.league = dan_StringModel.league;
                    liveScoreModel.leagueId = dan_StringModel.leagueId;
                    liveScoreModel.letgoal = dan_StringModel.rq2;
                    [_arrLiveScoreModelAll addObject:liveScoreModel];
                    
                }
                [_arrSelectCell addObject:arr];
                
            }
            
            
            [self.tabView reloadData];
            
            
            return;
        }else if (_type == 1 && _arrDataLeageue != 0){
            _arrData = _arrDataLeageue;
            self.arrDataAll = _arrDataLeageue;
            for (int i = 0; i < _arrData.count; i ++) {
                if (i == 0 && self.type == 0) {
                    [_arrSection addObject:@(1)];
                }else{
                    [_arrSection addObject:@(0)];
                }
                
                Dan_StringGuanModel *model = _arrData[i];
                NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
                
                for (int j = 0; j < model.matchs.count; j++) {
                    [arr addObject:@(0)];
                    
                    Dan_StringMatchsModel *dan_StringModel = model.matchs[j];
                    LiveScoreModel *liveScoreModel = [[LiveScoreModel alloc] init];
                    liveScoreModel.league = dan_StringModel.league;
                    liveScoreModel.leagueId = dan_StringModel.leagueId;
                    liveScoreModel.letgoal = dan_StringModel.rq2;
                    [_arrLiveScoreModelAll addObject:liveScoreModel];
                    
                }
                [_arrSelectCell addObject:arr];
                
            }
            [self.tabView reloadData];
            return;
        }
        
    }
    //    http://mobile.gunqiu.com/test-interface/quiz/match?visit=1&flag=0&type=1
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(self.flag) forKey:@"flag"];
    [parameter setObject:@(_type) forKey:@"type"];
    //    http://mobile.gunqiu.com/quiz/dg/time.json
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@",self.urlTypeStr] Start:^(id requestOrignal) {
        
        if (type == loadDataFirst) {
            
            if ([_jsonStr isEqualToString:@"all"]) {
                [LodingAnimateView showLodingView];

            }
            
        }
    } End:^(id responseOrignal) {
        if (type == loadDataFirst) {
            if ([_jsonStr isEqualToString:@"all"]) {
                [LodingAnimateView dissMissLoadingView];

            }

            
        }
        
        [self.tabView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        
        
        self.defaultFailure = @"暂无比赛";
        _saiXuanBtn.enabled = YES;
        //        NSLog(@"%@",responseOrignal);
        //        NSLog(@"%@",responseOrignal);
        _arrLiveScoreModelAll = [[NSMutableArray alloc] initWithCapacity:0];
        
        _arrSelectCell = [[NSMutableArray alloc] initWithCapacity:0];
        _arrSelectedMathch = [[NSMutableArray alloc] initWithCapacity:0];
        
        if (_type ==0) {
            _arrData = [[NSMutableArray alloc] initWithArray:[Dan_StringGuanModel arrayOfEntitiesFromArray:responseOrignal]];
            _arrDataTime = [[NSMutableArray alloc] initWithArray:[Dan_StringGuanModel arrayOfEntitiesFromArray:responseOrignal]];
        }else{
            _arrData = [[NSMutableArray alloc] initWithArray:[Dan_StringGuanModel arrayOfEntitiesFromArray:responseOrignal]];
            _arrDataLeageue = [[NSMutableArray alloc] initWithArray:[Dan_StringGuanModel arrayOfEntitiesFromArray:responseOrignal]];
        }
        
        
        self.arrDataAll = [Dan_StringGuanModel arrayOfEntitiesFromArray:responseOrignal];
        
        for (int i = 0; i < _arrData.count; i ++) {
            if (i == 0 && self.type == 0) {
                [_arrSection addObject:@(1)];
            }else{
                [_arrSection addObject:@(0)];
            }
            
            Dan_StringGuanModel *model = _arrData[i];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
            for (int j = 0; j < model.matchs.count; j++) {
                [arr addObject:@(0)];
                
                Dan_StringMatchsModel *dan_StringModel = model.matchs[j];
                LiveScoreModel *liveScoreModel = [[LiveScoreModel alloc] init];
                liveScoreModel.league = dan_StringModel.league;
                liveScoreModel.leagueId = dan_StringModel.leagueId;
                liveScoreModel.letgoal = dan_StringModel.rq2;
                [_arrLiveScoreModelAll addObject:liveScoreModel];
                
            }
            [_arrSelectCell addObject:arr];
        }
        
        
        
        [self.tabView reloadData];
        //将筛选里面记录的赛事清除
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
        NSString *documentPath = [Methods getDocumentsPath];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        NSLog(@"%@",error);
        self.defaultFailure = errorDict;
        [self.tabView reloadData];
    }];
}

//按时间显示
- (UIButton *)btnViewOne{
    if (!_btnViewOne) {
        _btnViewOne = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnViewOne.tag = 1;
        _btnViewOne.frame = CGRectMake(0, 0, (Width - 70)/2, 44);
        [_btnViewOne setTitle:@"按时间显示" forState:UIControlStateNormal];
        //默认选中
        _btnViewOne.selected = YES;
        [_btnViewOne setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnViewOne setTitleColor:color66 forState:UIControlStateNormal];
        _btnViewOne.titleLabel.font = font12;
        _btnViewOne.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btnViewOne addTarget:self action:@selector(btnClicktag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnViewOne;
}
- (UIView *)lineVinew{
    if (!_lineVinew) {
        _lineVinew = [[UIView alloc] initWithFrame:CGRectMake(Width - 71, 10, 0.5, 24)];
        _lineVinew.backgroundColor = colorCellLine;
    }
    return _lineVinew;
}
//按联赛显示
- (UIButton *)btnViewTwo{
    if (!_btnViewTwo) {
        _btnViewTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnViewTwo.tag = 2;
        _btnViewTwo.frame = CGRectMake((Width - 70)/2, 0, (Width - 70)/2, 44);
        [_btnViewTwo setTitle:@"按联赛显示" forState:UIControlStateNormal];
        [_btnViewTwo setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnViewTwo setTitleColor:color66 forState:UIControlStateNormal];
        _btnViewTwo.titleLabel.font = font12;
        _btnViewTwo.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btnViewTwo addTarget:self action:@selector(btnClicktag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnViewTwo;
}
#pragma mark ----------赛事筛选
- (void)saiXuan{

    
    
    NSString *str_url = [NSString stringWithFormat:@"%@/duizhen/%@/filter.json",APPDELEGATE.url_jsonHeader,_jsonStr];
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:str_url Start:^(id requestOrignal) {

    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        _arrDataShaiShiAll = [[NSMutableArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:responseOrignal[@"allindex"]]];
        _arrDataShaiShiOdds = [[NSMutableArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:responseOrignal[@"oddsindex"]]];
        _arrDataShaiShiJiCai = [[NSMutableArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:responseOrignal[@"jcindex"]]];
        
        SaishiSelecterdVC *selectedVC = [[SaishiSelecterdVC alloc] init];
        selectedVC.type = typeSaishiSelecterdVCTuijian;
        selectedVC.arrBifenData = _arrLiveScoreModelAll;
        selectedVC.arrData = _arrDataShaiShiAll;
        selectedVC.arrDataJingcai = _arrDataShaiShiJiCai;
        selectedVC.arrDataChupan = _arrDataShaiShiOdds;
        selectedVC.hidesBottomBarWhenPushed = YES;
        selectedVC.jincai = 1;
        [APPDELEGATE.customTabbar pushToViewController:selectedVC animated:YES];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];

}

- (void)updateByselectedsaishi:(NSNotification *)notification
{
    
    _arrLeagedChooes = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *AlldataArrary= [notification.userInfo objectForKey:@"arrData"];
    NSString *typeNum_QJC = [notification.userInfo objectForKey:@"type"];
    
    if ([typeNum_QJC isEqualToString:@"2"]) {
        for (int i = 0; i <  AlldataArrary.count; i ++) {
            LiveScoreModel *model =  AlldataArrary[i];
            if (![_arrLeagedChooes containsObject:model.letgoal]) {
                [_arrLeagedChooes addObject:model.letgoal];//筛选出赛事名称，不要重复的
            }
        }
        
    }else{
        for (int i = 0; i <  AlldataArrary.count; i ++) {
            LiveScoreModel *model =  AlldataArrary[i];
            if (![_arrLeagedChooes containsObject:model.league]) {
                [_arrLeagedChooes addObject:model.league];//筛选出赛事名称，不要重复的
            }
        }
    }
    [self chooesSaiShi:_arrLeagedChooes type:typeNum_QJC];

//    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:self.urlTypeStr Start:^(id requestOrignal) {
//        
//    } End:^(id responseOrignal) {
//    } Success:^(id responseResult, id responseOrignal) {
//
//        
//        
//        self.arrDataAll = [Dan_StringGuanModel arrayOfEntitiesFromArray:responseOrignal];
//
//        [self chooesSaiShi:_arrLeagedChooes type:typeNum_QJC];
//        
//        
//
//    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        NSLog(@"%@",error);
//    }];

}
#pragma mark ----------赛事筛选后，处理数据源
- (void)chooesSaiShi:(NSArray *)arrChooes type:(NSString *)type_QJC{
    _arrSelectCell = [[NSMutableArray alloc] initWithCapacity:0];
    if ([type_QJC isEqualToString:@"1"]) {
        [self shaiXuanLegue:arrChooes];
    }else{
        [self shaixuanRQ:arrChooes];
    }

    [_arrSelectedMathch removeAllObjects];

    [self.tabView reloadData];
}
#pragma mark ----------初盘筛选
- (void)shaixuanRQ:(NSArray *)arrChooes{
    NSArray *arrDataT = [[NSArray alloc] initWithArray:self.arrDataAll];
    _arrData  = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < arrDataT.count; i ++) {
        [_arrSection addObject:@(0)];
        Dan_StringGuanModel *model = arrDataT[i];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *arrMatch = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0; j < model.matchs.count; j++) {
            Dan_StringMatchsModel *matchModel = model.matchs[j];
            if ([arrChooes containsObject:matchModel.rq2]) {
                [arrMatch addObject:matchModel];
                [arr addObject:@(0)];
 
            }
        }
        model.matchs = arrMatch;
        [_arrData addObject:model];
        [_arrSelectCell addObject:arr];
        
    }
    
}
#pragma mark ----------联赛名称筛选
- (void)shaiXuanLegue:(NSArray *)arrChooes{
    if (_type == 0) {

        NSMutableArray *arrDataT = [[NSMutableArray alloc] initWithArray:self.arrDataAll];
        _arrData  = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < arrDataT.count; i ++) {
            [_arrSection addObject:@(0)];
            Dan_StringGuanModel *model = arrDataT[i];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *arrMatch = [[NSMutableArray alloc] initWithCapacity:0];
            for (int j = 0; j < model.matchs.count; j++) {
                Dan_StringMatchsModel *matchModel = model.matchs[j];
                if ([arrChooes containsObject:matchModel.league]) {
                    [arrMatch addObject:matchModel];
                    [arr addObject:@(0)];
                }
            }
            model.matchs = arrMatch;
            [_arrData addObject:model];
            [_arrSelectCell addObject:arr];
            
        }
        
        
    }else if(_type == 1){
        NSArray *arrDataT = self.arrDataAll;
        _arrData  = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < arrDataT.count; i ++) {
            
            Dan_StringGuanModel *model = arrDataT[i];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
            
            if ([arrChooes containsObject:model.index]) {
                [_arrSection addObject:@(0)];
                for (int j = 0; j < model.matchs.count; j++) {
                    [arr addObject:@(0)];

                }
                [_arrData addObject:model];
                [_arrSelectCell addObject:arr];
                
                
            }
            
        }
        
    }
}
#pragma mark ----------时间赛事切换按钮的代理方法
- (void)btnClicktag:(UIButton *)btn{
    
    if (btn.tag == 1) {
        _type = 0;
        self.urlTypeStr = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,[NSString stringWithFormat:@"/duizhen/%@/time.json",_jsonStr]];
        self.btnViewOne.selected = YES;
        self.btnViewTwo.selected = NO;
        
    }else{
        _type = 1;
        self.urlTypeStr = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,[NSString stringWithFormat:@"/duizhen/%@/league.json",_jsonStr]];
        self.btnViewOne.selected = NO;
        self.btnViewTwo.selected = YES;
    }
    [self getdataWithtype:loadDataReload];
}
- (UIView *)typeView{
    if (!_typeView) {
        _typeView = [[UIView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width, 40)];
        _typeView.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"smallSaiTwo"];
        [_typeView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(Width - 30);
            make.centerY.mas_equalTo(_typeView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(23, 23));
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"筛选  ";
        lab.textColor = color66;
        lab.font = font13;
        lab.textAlignment = NSTextAlignmentRight;
        [_typeView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(img.mas_left);
            make.centerY.mas_equalTo(img.mas_centerY);
        }];
        _saiXuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saiXuanBtn.frame = CGRectMake(Width - 70, 0, 140, 44);
        [_saiXuanBtn addTarget:self action:@selector(saiXuan) forControlEvents:UIControlEventTouchUpInside];
        _saiXuanBtn.enabled = NO;
        [_typeView addSubview:_saiXuanBtn];
        UIView *lineViewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.4, Width, 0.5)];
        lineViewLine.backgroundColor = colorDD;
        [_typeView addSubview:lineViewLine];
        
    }
    return _typeView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_arrSection[section] integerValue]== 1) {
        Dan_StringGuanModel *model = _arrData[section];
        return model.matchs.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 39;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    return 180;
//    NSArray *arr = _arrSelectCell[indexPath.section];
//    if ([arr[indexPath.row] integerValue]== 1) {
//        return 200;
//    }
    
    Dan_StringGuanModel *model = [_arrData objectAtIndex:indexPath.section];
    Dan_StringMatchsModel *matchModel = model.matchs[indexPath.row];
    if (matchModel.spf.count == 0 && matchModel.rq.count == 0 && matchModel.dx.count == 0) {
//                btn.backgroundColor = grayColor1;
        return 0;
    }

    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self createSectionViewRow:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *acell = @"acell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
    [cell.contentView removeAllSubViews];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.backgroundColor = [UIColor clearColor];
//    cell.delegate = self;
    Dan_StringGuanModel *model = [_arrData objectAtIndex:indexPath.section];
    Dan_StringMatchsModel *matchModel = model.matchs[indexPath.row];
    if (matchModel.spf.count == 0 && matchModel.rq.count == 0 && matchModel.dx.count == 0) {
        return [UITableViewCell new];
    }

    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.4, Width, 0.6)];
    lineView.backgroundColor = colorCellLine;
    [cell.contentView addSubview:lineView];
    UILabel *labLeage = [[UILabel alloc] initWithFrame:CGRectMake(10,9, 100, 15)];
    
    labLeage.text = [NSString stringWithFormat:@"%@",matchModel.league];
    labLeage.textColor = [Methods getColor:matchModel.leagueColor];
    labLeage.font = font11;
    if (_type == 0) {
        
    }else{//1为联赛
//        lab.frame = CGRectMake(10, 17, 100, 15);
        labLeage.textColor = color66;
        labLeage.text = [NSString stringWithFormat:@"%@",[Methods getDateByStyle:dateStyleFormatterMdHm withDate:[NSDate dateWithTimeIntervalSince1970:[matchModel.matchtime doubleValue]/1000]]];
        labLeage.text = [labLeage.text substringWithRange:NSMakeRange(0, 5)];
    }
    [cell.contentView addSubview:labLeage];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labLeage.left, labLeage.bottom, 100, 15)];
    lab.text = [NSString stringWithFormat:@"%@",[Methods getDateByStyle:dateStyleFormatterMdHm withDate:[NSDate dateWithTimeIntervalSince1970:[matchModel.matchtime doubleValue]/1000]]];
//    if (_type == 0) {
        lab.text = [lab.text substringWithRange:NSMakeRange(6, 5)];
//    }
    lab.textColor = color66;
    lab.font = font10;
    [cell.contentView addSubview:lab];
    


    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 10 - 7, 0, 7, 14)];
    
     img.image = [UIImage imageNamed:@"meRight"];
//    NSArray *arr = _arrSelectCell[indexPath.section];
//    if ([arr[indexPath.row] integerValue]== 1) {
//        [cell creteViewIndepath:indexPath];
//        NSArray *arrSelct = _arrBtnSelectModel[indexPath.section];
//        [cell sentModel_matchModel:matchModel selectModel:arrSelct[indexPath.row] indexPaht:indexPath];
//        img.image = [UIImage imageNamed:@"up"];
//    }else{
//        
//        img.image = [UIImage imageNamed:@"down"];
//    }
    [cell.contentView addSubview:img];

    
    UILabel *labTeameguestteam = [[UILabel alloc] initWithFrame:CGRectMake(img.x - 130, 0, 100, 44)];
    labTeameguestteam.textAlignment = NSTextAlignmentLeft;
    labTeameguestteam.textColor = color33;
    labTeameguestteam.font = font14;
    img.center = CGPointMake(img.center.x, labTeameguestteam.center.y);
    UILabel *labVS = [[UILabel alloc] initWithFrame:CGRectMake(labTeameguestteam.x - 25, 0, 20, 44)];
    labVS.textAlignment = NSTextAlignmentCenter;
    labVS.textColor = colorCC;
    labVS.font = font17;
    
    UILabel *labTeameHome = [[UILabel alloc] initWithFrame:CGRectMake(labVS.x - 105, 0, 100, 44)];
    labTeameHome.textAlignment = NSTextAlignmentRight;
    labTeameHome.textColor = color33;
    labTeameHome.font = font14;
    
    
    NSString *home = @"";
    NSString *gues = @"";
    if (matchModel.hometeam.length > 6) {
        home = [matchModel.hometeam substringToIndex:6];
    }else{
        home = matchModel.hometeam;
    }
    if (matchModel.guestteam.length > 6) {
        gues = [matchModel.guestteam substringToIndex:6];
    }else{
        gues = matchModel.guestteam;
    }
    
    labTeameHome.text = home;
    labTeameguestteam.text = gues;
    labVS.text = @"vs";
    
    
    //    [labTeame setAttributedText:[Methods withContent:labTeame.text contentColor:grayColor3 WithColorText:@"vs" textColor:grayColor34]];
    [cell.contentView addSubview:labTeameguestteam];
    [cell.contentView addSubview:labVS];
    [cell.contentView addSubview:labTeameHome];
    
    if (matchModel.spf.count == 0 && matchModel.rq.count == 0 && matchModel.dx.count == 0) {
        btn.enabled = NO;
//        btn.backgroundColor = grayColor1;
        labTeameHome.textColor = colorCC;
        labTeameguestteam.textColor = colorCC;
    }

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Dan_StringGuanModel *model = [_arrData objectAtIndex:indexPath.section];
//    Dan_StringMatchsModel *matchModel = model.matchs[indexPath.row];
//    RelRecNewVC *relVC = [[RelRecNewVC alloc] init];
//    relVC.hidesBottomBarWhenPushed = YES;
//    relVC.model = matchModel;
//    
//    [APPDELEGATE.customTabbar pushToViewController:relVC animated:YES];
    
}










- (void)cellClick:(id)sender{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    _indexPath = [self.tabView indexPathForCell:cell];
    Dan_StringGuanModel *model = [_arrData objectAtIndex:_indexPath.section];
    Dan_StringMatchsModel *matchModel = model.matchs[_indexPath.row];
    
    RelRecNewVC *relVC = [[RelRecNewVC alloc] init];
    relVC.hidesBottomBarWhenPushed = YES;
    relVC.model = matchModel;
    
    [APPDELEGATE.customTabbar pushToViewController:relVC animated:YES];
//    if (self.dan_Chuan == 0) {
//        NSMutableArray *arrOne = _arrSelectCell;
//        _arrSelectCell = [[NSMutableArray alloc] initWithCapacity:0];
//        for (int j = 0; j < arrOne.count; j ++) {
//            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrOne[j]];
//            NSMutableArray *arrTwo = [[NSMutableArray alloc] initWithCapacity:0];
//            for (int i = 0; i < arr.count; i ++) {
//                if (i == _indexPath.row) {
//                    if ([arr[_indexPath.row] integerValue] == 0) {
//                        if (matchModel.spf.count == 0) {
//                            [arrTwo addObject:@(0)];
//                        }else{
//                            [arrTwo addObject:@(1)];
//                        }
//                        
//                    }else{
//                        [arrTwo addObject:@(0)];
//                    }
//                }else{
//                    [arrTwo addObject:@(0)];
//                }
//                
//            }
//            [_arrSelectCell addObject:arrTwo];
//        }
//    }else{
//        
//        
//        for (int j = 0; j < _arrSelectCell.count; j ++) {
//            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:_arrSelectCell[j]];
//            for (int i = 0; i < arr.count; i ++) {
//                if (i == _indexPath.row) {
//                    [_arrSelectCell removeObjectAtIndex:j];
//                    if ([arr[i] integerValue] == 0) {
//                        [arr removeObjectAtIndex:i];
//                        [arr insertObject:@(1) atIndex:i];
//                    }else{
//                        [arr removeObjectAtIndex:i];
//                        [arr insertObject:@(0) atIndex:i];
//                    }
//                    [_arrSelectCell insertObject:arr atIndex:j];
//                }
//                
//                
//            }
//            
//        }
//    }
//    [self.tabView reloadData];
    
}

- (UIView *)createSectionViewRow:(NSInteger)row{
    Dan_StringGuanModel *model = [_arrData objectAtIndex:row];
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 39)];
//    sectionView.backgroundColor = [UIColor clearColor];
    sectionView.backgroundColor = [UIColor whiteColor];
    UILabel *lableague = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 150, 39)];
    lableague.font = font12;
    lableague.textColor = color66;

    int count = 0;
    for (int i = 0; i<model.matchs.count; i++) {
        Dan_StringMatchsModel *matchModel = model.matchs[i];
        if (matchModel.spf.count == 0 && matchModel.rq.count == 0 && matchModel.dx.count == 0) {
        }else{
            count ++;
        }

    }
    

    
    
    lableague.text = [NSString stringWithFormat:@"%@  %d场",model.index,count];
    lableague.attributedText = [Methods withContent:lableague.text contentColor:color66 WithColorText:[NSString stringWithFormat:@"  %d",count] textColor:redcolor];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 10, 7)];
    img.center = CGPointMake(img.center.x, sectionView.height/ 2);
    if ([_arrSection[row] integerValue]== 1) {
        img.image  = [Methods image:[UIImage imageNamed:@"hongSanJiao0"] rotation:UIImageOrientationUp];
        
    }else{
        img.width = 7;
        img.height = 10;
        img.image  = [Methods image:[UIImage imageNamed:@"hongSanJiao0"] rotation:UIImageOrientationLeft];
    }
    
    [sectionView addSubview:img];
    
    UIButton *btnSection = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sectionView.width, sectionView.height)];
    
    [btnSection addTarget:self action:@selector(clickSectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    btnSection.tag = row;
    [sectionView addSubview:lableague];
    [sectionView addSubview:btnSection];
    [_arrSectionBtn addObject:btnSection];
    [sectionView addSubview:[self lineViewFrame:CGRectMake(0, 38.4, Width, 0.6)]];
    return sectionView;
}
-(void)clickSectionBtn:(UIButton *)btn{
    NSMutableArray *arrSe = _arrSection;
    _arrSection = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0;  i < arrSe.count; i++) {
        if (i == btn.tag) {
            if ([arrSe[i] integerValue] == 1) {
                [_arrSection addObject:@(0)];
            }else{
                [_arrSection addObject:@(1)];
            }
            
        }else{
            [_arrSection addObject:@(0)];
        }
    }
    NSMutableArray *arrOne = _arrSelectCell;
    _arrSelectCell = [[NSMutableArray alloc] initWithCapacity:0];
    for (int j = 0; j < arrOne.count; j ++) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrOne[j]];
        NSMutableArray *arrTwo = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < arr.count; i ++) {
            
            [arrTwo addObject:@(0)];

        }
        [_arrSelectCell addObject:arrTwo];
    }
    
    [self.tabView reloadData];
}
-(UITableView *)tabView{
    if (!_tabView ) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.emptyDataSetSource = self;
        _tabView.emptyDataSetDelegate = self;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabView.backgroundColor = [UIColor whiteColor];
        
        [self setupTableViewMJHeader];
    }
    return _tabView;
}

//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
        
    }
    
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"white"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        NSString *text = self.defaultFailure;
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];

    }
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getdataWithtype:loadDataHeaderRefesh];
        
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tabView.mj_header = header;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(void)viewDidLayoutSubviews {
    
    if ([_tabView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tabView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tabView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tabView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UIView *)lineViewFrame:(CGRect)rect{
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = colorCellLine;
    
    return line;
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
