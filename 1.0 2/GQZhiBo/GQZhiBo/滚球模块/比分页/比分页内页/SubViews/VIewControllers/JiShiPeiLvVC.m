//
//  JiShiPeiLvVC.m
//  GQapp
//
//  Created by Marjoice on 10/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "JiShiPeiLvVC.h"
#import "JishiFirstCell.h"
#import "JiShiPeiLvCell.h"
#import "PeiLvDetailCell.h"
#import "JiShiPeiLvDetailModel.h"
#import "LiveScoreModel.h"

#define jiShiPeilvDetailCellID         @"jiShiPeilvDetailCell"
#define jiShiFirstCellID               @"jiShiPeiLvFirstCell"

@interface JiShiPeiLvVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *titleArr;

@end

@implementation JiShiPeiLvVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildTableView];
}
- (NSMutableArray *)titleArr {
    
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"让分即时赔率",@"大小即时赔率",@"角球让球赔率",@"角球大小赔率", nil];
    }
    return _titleArr;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[JishiFirstCell class] forCellReuseIdentifier:jiShiFirstCellID];
        [_tableView registerClass:[JiShiPeiLvCell class] forCellReuseIdentifier:jiShiPeilvDetailCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [self.tableView reloadData];
    }
    return _tableView;
}

- (void)buildTableView {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(Width);
    }];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    return [NSString stringWithFormat:@"%@",self.titleArr[section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
      
        JishiFirstCell *jiShiCell = [tableView dequeueReusableCellWithIdentifier:jiShiFirstCellID forIndexPath:indexPath];
        jiShiCell.jiShiPLFirstModel = [JiShiPLFirstModel new];
        jiShiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return jiShiCell;
    }else {
       
        JiShiPeiLvCell *jiShiPeiLvCell = [tableView dequeueReusableCellWithIdentifier:jiShiPeilvDetailCellID forIndexPath:indexPath];
        jiShiPeiLvCell.jiShiPeiLvDetailModel = [JiShiPeiLvDetailModel new];
        jiShiPeiLvCell.selectionStyle = UITableViewCellSelectionStyleNone;
        jiShiPeiLvCell.backgroundColor = colorFFFFFF;

        return jiShiPeiLvCell;
    }
    
    return nil;
}


#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont systemFontOfSize:14];
    header.contentView.backgroundColor = colorEEEEEE;
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = yellowColor1;
    UIImageView *arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuijianRule2"]];
    UILabel *titleLab = [UILabel new];
    titleLab.font = font14;
    titleLab.text = [NSString stringWithFormat:@"%@",self.titleArr[section]];
    
    [view addSubview:lineView];
    [view addSubview:titleLab];
    [view addSubview:arrowImg];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(view).offset(15);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(1, 38));
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lineView.mas_trailing).offset(10);
        make.centerY.equalTo(lineView);
        make.width.mas_equalTo(40);
    }];
    
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(view).offset(-15);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    return view;
}
 */

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 100.0;
//}


#pragma mark - loadJiShiPLData -
- (void)loadJiShiPLData {

    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(self.model.mid) forKey:@"matchId"];
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_JiShiPeiLv] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
       
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];
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
