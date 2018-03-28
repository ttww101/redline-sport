//
//  BifenSetingViewController.m
//  GunQiuLive
//
//  Created by WQ_h on 16/3/3.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "DCPlaySound.h"
static SystemSoundID shake_sound_id = 0;


#import "BifenSetingViewController.h"
#import "DCPlaySound.h"
#define Setcell @"Setcell"
//static SystemSoundID shake_sound_male_id = 0;
@interface BifenSetingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *setTableView;
@property (nonatomic, strong) NSMutableArray *arrPeilvBtns;
@property (nonatomic, strong) NSMutableArray *btnXianshiFS;
@property (nonatomic, strong) NSMutableArray *btnMoRenBF;
@property (nonatomic, strong) NSMutableArray *btnJinQiuTS;
@property (nonatomic, strong) NSMutableArray *btnHongPaiTS;
@property (nonatomic, strong) NSMutableArray *btnTiShiSY;
@property (nonatomic, strong) NSMutableArray *btnTiShiFW;
@property (nonatomic, strong) NSMutableArray *btnYuYan;
@property (nonatomic, strong) NSMutableArray *btnPanKou;
@property (nonatomic, strong) UIImageView *imageMatchtime;
@property (nonatomic, strong) UIImageView *imageLeaguename;
@property (nonatomic, strong) UIButton *btnoupei;
@property (nonatomic, strong) UIButton *btndaxiao;
@property (nonatomic, strong) UIButton *btnyapan;

//是否改变了显示竞彩编号，红牌，黄牌，角球，半场比分，这个设置不用加载数据，只需要重新加载页面就可以，只要在退出之后刷新一下就可以
@property (nonatomic, assign) BOOL changedShowSortType;
@end

@implementation BifenSetingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"设置";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
      
        NSMutableArray *arrPeilv = [NSMutableArray array];
        for (UIButton *btn in _arrPeilvBtns) {
            if (btn.selected) {
                [arrPeilv addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:arrPeilv forKey:@"befenSetingPeilv"];
        
       
        
        NSMutableArray *arrXianShi = [NSMutableArray array];
        for (UIButton *btn in _btnXianshiFS) {
            if (btn.selected) {
                [arrXianShi addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrXianShi forKey:@"beforeXianShi"];
        
        
        NSMutableArray *arrMoRenBF = [NSMutableArray array];
        for (UIButton *btn in _btnMoRenBF) {
            if (btn.selected) {
                [arrMoRenBF addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrMoRenBF forKey:@"BeforeMoRenBF"];
        
        
        NSMutableArray *arrTiShiFW = [NSMutableArray array];
        for (UIButton *btn in _btnTiShiFW) {
            if (btn.selected) {
                [arrTiShiFW addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrTiShiFW forKey:@"BeforeTiShiFW"];
        
        
        NSMutableArray *arrTiShiSY = [NSMutableArray array];
        for (UIButton *btn in _btnTiShiSY) {
            if (btn.selected) {
                [arrTiShiSY addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrTiShiSY forKey:@"BeforeTiShiSY"];
        
        
        NSMutableArray *arrJinQiuTS = [NSMutableArray array];
        for (UIButton *btn in _btnJinQiuTS) {
            if (btn.selected) {
                [arrJinQiuTS addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrJinQiuTS forKey:@"BeforeJinQiuTS"];
        
     
        NSMutableArray *arrHongPaiTS = [NSMutableArray array];
        for (UIButton *btn in _btnHongPaiTS) {
            if (btn.selected) {
                [arrHongPaiTS addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrHongPaiTS forKey:@"BeforeHongPaiTS"];
        
    
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"hasSetted"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        if (_changedListType) {
            //按什么顺序排列
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationchangeShowType" object:nil];
        }
        if (_changedShowSortType) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationCenterupdateWhetherShowSort" object:nil];

        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
            
            //如果有黄条就不重新请求
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationTogetAllJishibifen" object:nil];
            
        }

        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }else if(index == 2){
        //right
        
        
    }
}


- (void)baseArrWithName:(NSMutableArray *)arrName inArr:(NSMutableArray *)arr setObjForkey:(NSString *)keyName {
    
    arrName = [NSMutableArray array];
    for (UIButton *btn in arr) {
        if (btn.selected) {
            [arrName addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:arrName forKey:keyName];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
    self.setTableView.backgroundColor = colorF5;
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    self.setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.setTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Setcell];
    self.navigationItem.title = @"设置";
    [self.view addSubview:self.setTableView];
    [self setNavView];
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
            
        case 1:
            return 4; //6
            break;
        case 2:
            return 5; //2 //6
            break;
//        case 3:
//            return 0; //3
//            break;
        case 3:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Setcell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Setcell];
    }
    
    while (cell.contentView.subviews.lastObject != nil) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width, 0.5)];
    viewLine.backgroundColor = colorDD;
    [cell.contentView addSubview:viewLine];

    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 80, 44)];
    lab.font = font15;
    lab.textColor = color33;
    //    lab.backgroundColor = cellLineColor;
    [cell.contentView addSubview:lab];
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(Width - 60, 0, 51, 28)];
    switchBtn.center = CGPointMake(switchBtn.center.x, 22);
    switchBtn.onTintColor = redcolor;
    [switchBtn addTarget:self action:@selector(switchBtn:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switchBtn];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    lab.text = @"显示方式";
                    switchBtn.tag = 0;
                    switchBtn.hidden = YES;
                    
                    NSArray *arrXianShi = [[NSUserDefaults standardUserDefaults] arrayForKey:@"beforeXianShi"];
                    
                    _btnXianshiFS = [NSMutableArray array];
                    
                    
                    for (int i = 1; i < 3; i++) {
                        
                        UIButton *btnXianShi = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnXianShi.frame = CGRectMake(Width - 30 - 68*(i) - 10*(i-1), 0, 68, 44);
                        [btnXianShi setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"xianshifangshi%d",i]] forState:UIControlStateNormal];
                        [btnXianShi setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"xianshifangshisel%d",i]] forState:UIControlStateSelected];
                        btnXianShi.tag = i + 1000;
;
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"beforeXianShi"]) {
                            
                            if (btnXianShi.tag == 1002) {
                                
                                btnXianShi.selected = YES;
                                
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaishijian"];
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kaisaisaishi"];
                                
                                _changedListType = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                            for (NSString *numP in arrXianShi) {
                                if (i+1000 == [numP intValue]) {
                                    btnXianShi.selected = YES;
                                }
                            }
                            
                        }
                        
                        [btnXianShi addTarget:self action:@selector(xianshiClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnXianShi];
                        [_btnXianshiFS addObject:btnXianShi];
                        
                    }
                    
                    
//                    _imageMatchtime = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 10 - 18, 0, 18, 13)];
//                    _imageMatchtime.center = CGPointMake(_imageMatchtime.center.x, 44/2);
//                    [cell.contentView addSubview:_imageMatchtime];
//                    
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaishijian"]) {
//                        _imageMatchtime.image = [UIImage imageNamed:@"selectedPlay"];
//                    }else{
//                        _imageMatchtime.image = [UIImage imageNamed:@"clear"];
//
//                    }
                    
                }
                    break;
                case 1:
                {
                    lab.text = @"默认比分";
                    switchBtn.tag = 1;
                    switchBtn.hidden = YES;
                    
                    NSArray *arrMoRenBF = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeMoRenBF"];
                    _btnMoRenBF = [NSMutableArray array];
                    
                    
                    for (int i = 1; i < 3; i++) {   // 4 隐藏热门
                        
                        UIButton *btnMoRenBF = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnMoRenBF.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnMoRenBF setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"morenbifen%d",i]] forState:UIControlStateNormal];
                        [btnMoRenBF setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"morenbifensel%d",i]] forState:UIControlStateSelected];
                        btnMoRenBF.selected = NO;
                        btnMoRenBF.tag = i + 2000;
                        
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeMoRenBF"]) {
                            
                            if (btnMoRenBF.tag == 2002) {
                                
                                btnMoRenBF.selected = YES;
                            }
                        }else{
                        
                            for (NSString *numP in arrMoRenBF) {
                                if (i+2000 == [numP intValue]) {
                                    btnMoRenBF.selected = YES;
                                    
                                }
                            }
                        }

                        [btnMoRenBF addTarget:self action:@selector(moRenBFClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnMoRenBF];
                        [_btnMoRenBF addObject:btnMoRenBF];
                        
                    }

                    
//                    _imageLeaguename = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 18 - 10, 0, 18, 13)];
//                    _imageLeaguename.center = CGPointMake(_imageLeaguename.center.x, 44/2);
//                    [cell.contentView addSubview:_imageLeaguename];
//                    
//                    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaishijian"]) {
//                        _imageLeaguename.image = [UIImage imageNamed:@"selectedPlay"];
//                    }else{
//                        _imageLeaguename.image = [UIImage imageNamed:@"clear"];
//                        
//                    }
////                    viewLine.backgroundColor = [UIColor clearColor];
//
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    lab.text = @"球队排名";
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"qiuduipaiming"]) {   //半场比分 banchang
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                        
                    }
                    switchBtn.tag = 10;
                }
                    
                  /*
                    lab.text = @"球队排名";
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"banchang"]) {   //半场比分
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                        
                    }
                    switchBtn.tag = 10;
                    break;
                   */
                   
                    break;
                case 2:
                    lab.text = @"角球数";
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jiaoqiu"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                        
                    }
                    switchBtn.tag = 11;
                    break;
                case 3:
                    lab.text = @"红黄牌";
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpai"]) {       //黄牌
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                    }
                    switchBtn.tag = 12;
                    break;
                    
                    
                    /*
                case 4:
                {
                    lab.text = @"语言";
                    switchBtn.hidden = YES;

//                    NSArray *arrYuYan = [[NSUserDefaults standardUserDefaults] arrayForKey:@"beforeYuYan"];
                    
                    _btnYuYan = [NSMutableArray array];
                    
                    
                    for (int i = 1; i < 3; i++) {
                        
                        UIButton *btnYuYan = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnYuYan.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnYuYan setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"yuyan%d",i]] forState:UIControlStateNormal];
                        [btnYuYan setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"yuyansel%d",i]] forState:UIControlStateSelected];
                        
//                        for (NSString *numP in arrYuYan) {
//                            if (i == [numP intValue]) {
//                                btnYuYan.selected = YES;
//                                
//                            }
//                        }
//                        
                        btnYuYan.tag = i + 7000;
                        if (btnYuYan.tag == 7002) {
                            btnYuYan.selected = YES;
                        }else{
                            btnYuYan.selected = NO;
                        }
                        [btnYuYan addTarget:self action:@selector(yuYanClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnYuYan];
                        [_btnYuYan addObject:btnYuYan];
                        
                    }

                    
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpai"]) {
//                        switchBtn.on = YES;
//                    }else{
//                        switchBtn.on = NO;
//                        
//                    }
//                    switchBtn.tag = 13;
            }
                    break;
                    
                    
                    */
                case 1:
                    lab.text = @"编号(竞彩、北单、足彩)";
                    [lab setAttributedText:[Methods withContent:@"编号(竞彩、北单、足彩)" WithColorText:@"(竞彩、北单、足彩)" textColor:grayColor3 strFont:font11]];
                    
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"bianhao"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                        
                    }
                    switchBtn.tag = 14;
                    break;
                case 4: //5
                {
                    lab.text = @"盘赔";     //赔率显示 (3选2)
                    switchBtn.tag = 15;
                    switchBtn.hidden = YES;
//                    [lab setAttributedText:[Methods withContent:@"赔率显示 (3选2)" WithColorText:@"(3选2)" textColor:grayColor3 strFont:font13]];
                    
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"peilv"]) {
//                        switchBtn.on = YES;
//                    }else{
//                        switchBtn.on = NO;
//
//                    }
                    //本地存储的赔率
                    NSArray *arrPeilv = [[NSUserDefaults standardUserDefaults] arrayForKey:@"befenSetingPeilv"];

                    _arrPeilvBtns = [NSMutableArray array];
                    
                    /*
                    for (int i = 1; i<4; i++) {
                        
                        UIButton *btnPeilv = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnPeilv.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnPeilv setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"pankou%d",i]] forState:UIControlStateNormal];
                        [btnPeilv setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"pankousel%d",i]] forState:UIControlStateSelected];
                        btnPeilv.tag = i + 8000;

                        for (NSString *numP in arrPeilv) {
                            if (i+8000 == [numP intValue]) {
                                btnPeilv.selected = YES;

                            }
//                            if (btnPeilv.tag == 8001||btnPeilv.tag == 8002) {
//                                btnPeilv.selected = YES;
//                            }else{
//                                btnPeilv.selected = NO;
//                            }
                        }
                        
                     
                     */
                    
                    
//                    [btnPeilv addTarget:self action:@selector(selectedPeilv:) forControlEvents:UIControlEventTouchUpInside];
//                    [cell.contentView addSubview:btnPeilv];
//                    [_arrPeilvBtns addObject:btnPeilv];
//                    }
                 
                    
                    self.btnoupei= [UIButton buttonWithType:UIButtonTypeCustom];
                    self.btnoupei.frame = CGRectMake(Width - 10 - 68, 0, 68, 44);
                    [self.btnoupei setBackgroundImage:[UIImage imageNamed:@"pankou1"] forState:UIControlStateNormal];
                    [self.btnoupei setBackgroundImage:[UIImage imageNamed:@"pankousel1"] forState:UIControlStateSelected];
                    self.btnoupei.tag = 8000;
//                    self.btnoupei.selected =   NO;
                    [self.btnoupei addTarget:self action:@selector(selectedPeilv:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:self.btnoupei];
                    [_arrPeilvBtns addObject:self.btnoupei];
                    
                    self.btndaxiao = [UIButton buttonWithType:UIButtonTypeCustom];
                    self.btndaxiao.frame = CGRectMake(Width - 10 - 68*2, 0, 68, 44);
                    [self.btndaxiao setBackgroundImage:[UIImage imageNamed:@"pankou2"] forState:UIControlStateNormal];
                    [self.btndaxiao setBackgroundImage:[UIImage imageNamed:@"pankousel2"] forState:UIControlStateSelected];
                    self.btndaxiao.tag = 8001;
//                    self.btndaxiao.selected = YES;
                    [self.btndaxiao addTarget:self action:@selector(selectedPeilv:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:self.btndaxiao];
                    [_arrPeilvBtns addObject:self.btndaxiao];
                    
                    self.btnyapan = [UIButton buttonWithType:UIButtonTypeCustom];
                    self.btnyapan.frame = CGRectMake(Width - 10 - 68*3, 0, 68, 44);
                    [self.btnyapan setBackgroundImage:[UIImage imageNamed:@"pankou3"] forState:UIControlStateNormal];
                    [self.btnyapan setBackgroundImage:[UIImage imageNamed:@"pankousel3"] forState:UIControlStateSelected];
                    self.btnyapan.tag = 8002;
//                    self.btnyapan.selected = YES;
                    [self.btnyapan addTarget:self action:@selector(selectedPeilv:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:self.btnyapan];
                    [_arrPeilvBtns addObject:self.btnyapan];
                    
//                    if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"befenSetingPeilv"]) {
//
//                        self.btnyapan.selected = YES;
//                        self.btndaxiao.selected = YES;
//                        self.btnoupei.selected = NO;
//                    }else{
                    
                        for (NSString *numP in arrPeilv) {
                            if (8000 == [numP intValue]) {
                                
                                self.btnoupei.selected =  YES;
                            }
                            if (8001 == [numP intValue]) {
                                
                                self.btndaxiao.selected =  YES;
                            }
                            if (8002 == [numP intValue]) {
                              
                                self.btnyapan.selected =  YES;
                            }
                            
//                        }
                    }
//                    viewLine.backgroundColor = [UIColor clearColor];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 2:
                {
                    lab.text = @"提示声音";
                    switchBtn.hidden = YES;

                    NSArray *arrTiShiSY = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiSY"];
                    _btnTiShiSY = [NSMutableArray array];
                    
                    
                    for (int i = 1; i < 4; i++) {
                        
                        UIButton *btnTiShiSY = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnTiShiSY.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnTiShiSY setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishishengyin%d",i]] forState:UIControlStateNormal];
                        [btnTiShiSY setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishishengyinsel%d",i]] forState:UIControlStateSelected];
                        btnTiShiSY.selected = NO;
                        btnTiShiSY.tag = i + 5000;

                        
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiSY"]) {

                            if (btnTiShiSY.tag == 5001) {
                                
                                btnTiShiSY.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"koushao"];
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huanhu"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                        
                            for (NSString *numP in arrTiShiSY) {
                                if (i+5000 == [numP intValue]) {
                                    btnTiShiSY.selected = YES;
                                    
                                }
                            }
                        }
                        
                        [btnTiShiSY addTarget:self action:@selector(tiShiSYClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnTiShiSY];
                        [_btnTiShiSY addObject:btnTiShiSY];
                        
                    }

                    
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"shengyin"]) {
//                        switchBtn.on = YES;
//                    }else{
//                        switchBtn.on = NO;
//                        
//                    }
//                    switchBtn.tag = 20;
                }
                    break;
                case 0:
                {
                    lab.text = @"进球提示";
                    switchBtn.hidden = YES;

                    NSArray *arrJinQiuTS = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeJinQiuTS"];
                    _btnJinQiuTS = [NSMutableArray array];
                    
                    
                    for (int i = 1; i < 4; i++) {
                        
                        UIButton *btnJinQiuTS = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnJinQiuTS.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnJinQiuTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiu%d",i]] forState:UIControlStateNormal];
                        [btnJinQiuTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiusel%d",i]] forState:UIControlStateSelected];
                        btnJinQiuTS.tag = i + 3000;
                        
                        
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeJinQiuTS"]) {
                            
                            if (btnJinQiuTS.tag == 3001 || btnJinQiuTS.tag == 3003) {
                                
                                btnJinQiuTS.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiutanchuan"];
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiushengying"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                        
                            for (NSString *numP in arrJinQiuTS) {
                                if (i+3000 == [numP intValue]) {
                                    btnJinQiuTS.selected = YES;
                                }
                            }
                        }
                        
                        [btnJinQiuTS addTarget:self action:@selector(jinQiuTSClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnJinQiuTS];
                        [_btnJinQiuTS addObject:btnJinQiuTS];
                        
                    }

                    
//                    switchBtn.tag = 21;
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiu"]) {
//                        switchBtn.on = YES;
//                    }else{
//                        switchBtn.on = NO;
//                        
//                    }
                }
                    break;
                case 3:
                {
                    lab.text = @"提示范围";
                    switchBtn.hidden = YES;

                    NSArray *arrTiShiFW = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiFW"];
                    _btnTiShiFW = [NSMutableArray array];
                    
                    
                    for (int i = 1; i < 3; i++) {
                        
                        UIButton *btnTiShiFW = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnTiShiFW.frame = CGRectMake(Width - 15 - 81.5*(i) - 10*(i -1), 0, 81.5, 44);
                        [btnTiShiFW setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishifanwei%d",i]] forState:UIControlStateNormal];
                        [btnTiShiFW setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishifanweisel%d",i]] forState:UIControlStateSelected];
                        btnTiShiFW.selected = NO;
                        btnTiShiFW.tag = i + 6000;

                        
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiFW"]) {
                            
                            if (btnTiShiFW.tag == 6001) {
                                
                                btnTiShiFW.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionMe"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                        
                            for (NSString *numP in arrTiShiFW) {
                                if (i+6000 == [numP intValue]) {
                                    btnTiShiFW.selected = YES;
                                    
                                }
                            }
                        }

                        [btnTiShiFW addTarget:self action:@selector(tiShiFWClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnTiShiFW];
                        [_btnTiShiFW addObject:btnTiShiFW];
                        
                    }

                    
//                    switchBtn.tag = 22;
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"zhendong"]) {
//                        switchBtn.on = YES;
//                    }else{
//                        switchBtn.on = NO;
//                        
//                    }
//                    viewLine.backgroundColor = [UIColor clearColor];
            }
                    break;
                case 1:
                {
                    lab.text = @"红牌提示";
                    switchBtn.hidden = YES;

                    
                    
                    NSArray *arrHongPaiTS = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeHongPaiTS"];
                    _btnHongPaiTS = [NSMutableArray array];
                    
                    
                    for (int i = 1; i < 4; i++) {
                        
                        UIButton *btnHongPaiTS = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnHongPaiTS.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnHongPaiTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiu%d",i]] forState:UIControlStateNormal];
                        [btnHongPaiTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiusel%d",i]] forState:UIControlStateSelected];
                        btnHongPaiTS.tag = i + 4000;

                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeHongPaiTS"]) {

                            if (btnHongPaiTS.tag == 4001 || btnHongPaiTS.tag == 4003) {
                                
                                btnHongPaiTS.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitanchuang"];
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitishi"];
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaishenying"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                        
                            for (NSString *numP in arrHongPaiTS) {
                                if (i+4000 == [numP intValue]) {
                                    btnHongPaiTS.selected = YES;
                                    
                                }
                            }
                        }

                        [btnHongPaiTS addTarget:self action:@selector(hongPaiTSClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnHongPaiTS];
                        [_btnHongPaiTS addObject:btnHongPaiTS];
                        
                    }

                    
//                    switchBtn.tag = 23;
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaitishi"]) {
//                        switchBtn.on = YES;
//                    }else{
//                        switchBtn.on = NO;
//                        
//                    }
//                    viewLine.backgroundColor = [UIColor clearColor];
            }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
//        case 3:
//        {
//            lab.text = @"推送设置";
//            switchBtn.hidden = YES;
//            
//            
//            UIImageView *roolImg = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 55/2 - 18 / 2, 0, 18, 13)];
//            roolImg.center = CGPointMake(roolImg.center.x, 44/2);
//            roolImg.image = [UIImage imageNamed:@"redRoolImg"];
//            [cell.contentView addSubview:roolImg];
//
//
////            switchBtn.tag = 0;
////            _imageMatchtime = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 10 - 18, 0, 18, 13)];
////            _imageMatchtime.center = CGPointMake(_imageMatchtime.center.x, 44/2);
////            [cell.contentView addSubview:_imageMatchtime];
////            
////            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaishijian"]) {
////                _imageMatchtime.image = [UIImage imageNamed:@"selectedPlay"];
////            }else{
////                _imageMatchtime.image = [UIImage imageNamed:@"clear"];
////                
//            }
//            
//    break;

    
        case 3: //4
        {
            switch (indexPath.row) {
                case 0: //1
                    lab.text = @"屏幕防休眠";
                    switchBtn.tag = 31;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"screenSleep"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                        
                    }
                    break;
                case 1: //2
                    lab.text = @"夜间免打扰";
                    //23:00 ~ 7:00
                    switchBtn.tag = 32;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightStop"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                        
                    }
//                    viewLine.backgroundColor = [UIColor clearColor];

                    break;
//                case 0:
//                    lab.text = @"只提示我关注的";
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"attentionMe"]) {
//                        switchBtn.on = YES;
//                    }else{
//                        switchBtn.on = NO;
//                        
//                    }
//                    switchBtn.tag = 30;
//                    break;
//                    
//                case 3:
//                    lab.text = @"";
//                    switchBtn.tag = 8;
//                    
//                    break;
//                    
                default:
                    break;
            }
        }
            break;
            
            
        default:
            break;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return  10;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 32 + 40;
    }
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    view.backgroundColor = colorF5;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 44/2 - 6, Width - 40, 12)];
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(view.mas_centerX);
//        make.leading.equalTo(view);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(100);    //
//    }];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = font15;
    lab.textColor = redcolor;
    switch (section) {
        case 0:
            lab.text = @"比分设置";
            break;
            
        case 1:
            lab.text = @"";
            break;
        case 2:
            lab.text = @"显示设置";
            break;
//        case 3:
////            lab.text = @"";
//            break;
        case 3:
            lab.text = @"其他设置";
            break;
            
        default:
            break;
    }
    [view addSubview:lab];
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) { //4
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 32 + 40)];
        footer.backgroundColor = colorTableViewBackgroundColor;
        UILabel *labDetail = [[UILabel alloc] initWithFrame:CGRectMake(20, 72 / 2, Width-40, 32)];
        labDetail.numberOfLines = 0;
        labDetail.font = font11;
        labDetail.textColor = grayColor34;
        labDetail.text = @"提示:开启夜间免打扰，滚球APP只会在早上8:00---晚上23：00提醒和推送内容";
        [footer addSubview:labDetail];
        return footer;

    }
    return nil;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //            _imageMatchtime.image = [UIImage imageNamed:@"selectedPlay"];
            //            _imageLeaguename.image = [UIImage imageNamed:@"clear"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaishijian"];
            _changedListType = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];

        }else if (indexPath.row ==1){
            _imageLeaguename.image = [UIImage imageNamed:@"selectedPlay"];
            _imageMatchtime.image = [UIImage imageNamed:@"clear"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kaisaishijian"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
            _changedListType = YES;

        }
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
            
            
            
        }else{

        }
    }
}
*/

- (void)switchBtn:(UISwitch *)switchBtn
{
    NSLog(@"%ld,%d",(long)switchBtn.tag,switchBtn.on);
    switch (switchBtn.tag) {
        case 0:
        {
        }
            break;
        case 1:
        {
        }
            break;
            
        case 2:
        {
        }
            break;
            
        case 3:
        {
        }
            break;
            
        case 4:
        {
        }
            break;
            
        case 5:
        {
        }
            break;
            
        case 10:
        {
            _changedShowSortType = YES;

            //球队排名显示
            if (switchBtn.on) {
                
//                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"banchang"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"qiuduipaiming"];
           
            }else{
                
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"banchang"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"qiuduipaiming"];
                
            }
        }
            break;
            
        case 11:
        {
            _changedShowSortType = YES;

            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jiaoqiu"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jiaoqiu"];
            }
        }
            break;
            
        case 12:
        {
            _changedShowSortType = YES;

            //夜间免打扰
            if (switchBtn.on) {
                
//                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huangpai"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpai"];

            }else{
                
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huangpai"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpai"];

            }
        }
            break;
        case 13:
        {
            _changedShowSortType = YES;

//            //夜间免打扰
//            if (switchBtn.on) {
//                
//                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpai"];
//            }else{
//                
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpai"];
//            }
        }
            break;
        case 14:
        {
            _changedShowSortType = YES;
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"bianhao"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"bianhao"];
            }
        }
            break;
        case 15:
        {
            _changedShowSortType = YES;

            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"peilv"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"peilv"];
            }
        }
            break;
        case 20:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shengyin"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"shengyin"];
            }
        }
            break;
        case 21:
        {
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiu"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiu"];
            }
            
            
//            [self musicShowJinqiu];
            
        }
            break;
        case 22:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zhendong"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"zhendong"];
            }
        }
            break;
        case 23:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitishi"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaitishi"];
            }
        }
            break;
        case 24:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 25:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 30:
        {
            //只提示我关注的
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"attentionMe"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionMe"];
            }
        }
            break;
        case 31:
        {
            //屏幕休眠
            if (switchBtn.on) {
                
                [UIApplication sharedApplication].idleTimerDisabled =YES;
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"screenSleep"];
                
            }else{
                [UIApplication sharedApplication].idleTimerDisabled =NO;
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"screenSleep"];
            
            }
        }
            break;
        case 32:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"nightStop"];
                
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"nightStop"];
                
            }
        }
            break;
        case 33:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 34:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 35:
        {
            //夜间免打扰
            if (switchBtn.on) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
            
        default:
            break;
    }
}

//盘口 tag: i + 8000
- (void)selectedPeilv:(UIButton *)btn
{
//    int count= 0;
//    for (UIButton *btns in _arrPeilvBtns) {
//        if (btns.selected) {
//            count ++;
//            if (count == 2) {
//                if (btn.selected) {
//                    btn.selected = NO;
//                    return;
//                }
//                return;
//            }
//
//        }
//
//    }
//    btn.selected = !btn.selected;
/*
    int count = 0 ;
    for (UIButton *btns in _arrPeilvBtns){
        if (!btns.selected) {
            count++;
            btns.selected = YES;
            if (count == 1) {
                if (btns.selected) {
                    count ++;
                    btns.selected = YES;
                    if (count == 2) {
                        if (!btns.selected) {
                            btns.selected = YES;
                        }else{
                            btns.selected = NO;
                        }
                    }
                }else{
                    btns.selected = NO; //
                }
            }
        }else{
            btns.selected = NO;
        }
    }
 
 */
    
    switch (btn.tag) {
        case 8000:
            //欧赔
            if (!self.btnoupei.selected) {
                self.btnoupei.selected = YES;
                self.btnyapan.selected = NO;
                self.btndaxiao.selected = YES;
            }
            break;

        case 8001:
            //大小
            if (!self.btndaxiao.selected) {
                self.btndaxiao.selected = YES;
                self.btnoupei.selected = NO;
                self.btnyapan.selected = YES;
            }
            
            break;
        case 8002:
            //压盘
            if (!self.btnyapan.selected) {
                self.btnyapan.selected = YES;
                self.btndaxiao.selected = NO;
                self.btnoupei.selected = YES;
            }
            
            break;
        default:
            break;
    }
}
    
// stag i + 1000
- (void)xianshiClick:(UIButton *)btn {
   
    int count = 0;
    for (UIButton *yYBtn in _btnXianshiFS) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;

    switch (btn.tag) {
        case 1001:
            if (btn.selected == YES) {
//                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ansaishi"];
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"anshijian"];
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kaisaishijian"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaisaishi"];

                _changedListType = YES;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
[[NSUserDefaults standardUserDefaults] synchronize];
            }else{
            
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ansaishi"];
            }
            break;
        case 1002:
            if (btn.selected == YES) {
//                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"anshijian"];
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ansaishi"];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaishijian"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kaisaisaishi"];

                _changedListType = YES;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
[[NSUserDefaults standardUserDefaults] synchronize];
            }else{
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"anshijian"];
           
            }
            break;
            
        default:
            break;
    }
}

// tag i + 2000
- (void)moRenBFClick:(UIButton *)btn {
    
    int count = 0;
    for (UIButton *yYBtn in _btnMoRenBF) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 2001:
        {
            //竞彩
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"allbifen"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jingcaibifen"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        case 2002:
        {
            //全部
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"allbifen"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jingcaibifen"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
            
        default:
            break;
    }
}

// tag i + 3000
- (void)jinQiuTSClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 3001:
        {
            //弹窗
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiutanchuan"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiutanchuan"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
            
        case 3002:
        {
            //震动
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiuzhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiuzhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

            }
        }
            break;
        case 3003:
        {
            //声音
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiushengying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiushengying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
            
        default:
            break;
    }
    btn.selected = !btn.selected;
}

// tag i + 4000
- (void)hongPaiTSClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 4001:
        {
            //弹窗
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitanchuang"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaitanchuang"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
            
        case 4002:
        {
            //震动
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaizhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];

            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaizhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

            }
        }
            break;
        case 4003:
        {
            //声音
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaishenying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaishenying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
            
        default:
            break;
    }

    btn.selected = !btn.selected;
}

// tag i + 5000
- (void)tiShiSYClick:(UIButton *)btn {
    
    
    int count = 0;
    for (UIButton *yYBtn in _btnTiShiSY) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
//                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huanhu"];
                btn.selected = NO;
            }
        }
        
    }
    
    btn.selected = !btn.selected;
    
    switch (btn.tag) {
        case 5001:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"koushao"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huanhu"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self setMusicFunc];

            }
//            else{
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"koushao"];
//                
//            }
        }
            break;
        case 5002:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huanhu"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"koushao"];

                [[NSUserDefaults standardUserDefaults] synchronize];
                [self setMusicFunc];
            }
//            else{
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huanhu"];
//                
//            }
        }
            break;
        default:
            break;
            }
    
}


// tag i + 6000
- (void)tiShiFWClick:(UIButton *)btn {
    
    int count = 0;
    for (UIButton *yYBtn in _btnTiShiFW) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 6001:
        {
            //全部
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionMe"];

        }
            break;
        case 6002:
        {
            //关注的
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"attentionMe"];

        }
            break;
        default:
            break;
    }
}

// tag i + 7000
- (void)yuYanClick:(UIButton *)btn {

    int count = 0;
    for (UIButton *yYBtn in _btnYuYan) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
}

- (void)musicShowJinqiu
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"]) {
            
            NSString *path = nil;
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
                
                path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
            }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
                
                path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
            }
            if (path) {
                //注册声音到系统
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
                AudioServicesPlaySystemSound(shake_sound_id);
    //        AudioServicesPlaySystemSound(shake_sound_id);//如果无法再下面播放，可以尝试在此播放
            }
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
                
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
            }
            //    AudioServicesPlaySystemSound(shake_sound_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
            
            

        }else{
        
            // 不需要声音
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
                
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
            }
        }
        
    }


- (void)setMusicFunc {

    NSString *path = nil;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
    }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
        
        path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
    }
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
        AudioServicesPlaySystemSound(shake_sound_id);
        //        AudioServicesPlaySystemSound(shake_sound_id);//如果无法再下面播放，可以尝试在此播放
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
        
        //            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
    }
    //    AudioServicesPlaySystemSound(shake_sound_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）

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
