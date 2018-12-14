#import "ZBJiShiPeiLvVC.h"
#import "ZBJishiFirstCell.h"
#import "ZBJiShiPeiLvCell.h"
#import "ZBPeiLvDetailCell.h"
#import "ZBJiShiPeiLvDetailModel.h"
#import "ZBLiveScoreModel.h"
#define jiShiPeilvDetailCellID         @"jiShiPeilvDetailCell"
#define jiShiFirstCellID               @"jiShiPeiLvFirstCell"
@interface ZBJiShiPeiLvVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *titleArr;
@end
@implementation ZBJiShiPeiLvVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTableView];
}
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"让分即时指数",@"大小即时指数",@"角球让球指数",@"角球大小指数", nil];
    }
    return _titleArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[ZBJishiFirstCell class] forCellReuseIdentifier:jiShiFirstCellID];
        [_tableView registerClass:[ZBJiShiPeiLvCell class] forCellReuseIdentifier:jiShiPeilvDetailCellID];
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
        ZBJishiFirstCell *jiShiCell = [tableView dequeueReusableCellWithIdentifier:jiShiFirstCellID forIndexPath:indexPath];
        jiShiCell.jiShiPLFirstModel = [ZBJiShiPLFirstModel new];
        jiShiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return jiShiCell;
    }else {
        ZBJiShiPeiLvCell *jiShiPeiLvCell = [tableView dequeueReusableCellWithIdentifier:jiShiPeilvDetailCellID forIndexPath:indexPath];
        jiShiPeiLvCell.jiShiPeiLvDetailModel = [ZBJiShiPeiLvDetailModel new];
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
#pragma mark - loadJiShiPLData -
- (void)loadJiShiPLData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setObject:@(self.model.mid) forKey:@"matchId"];
    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_JiShiPeiLv] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
