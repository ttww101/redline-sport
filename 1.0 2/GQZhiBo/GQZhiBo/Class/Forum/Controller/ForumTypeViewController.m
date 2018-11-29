//
//  ForumTypeViewController.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ForumTypeViewController.h"
#import "SectionView.h"
#import "NavView.h"
#import "Excellent.h"

@interface ForumTypeViewController () <UITableViewDataSource, UITableViewDelegate, SectionViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<HeaderInfoModel *> *headers;
@property (nonatomic, strong) NSMutableArray<CommentModel *> *comments;
@property (nonatomic, strong) BaseImageView *bgIV;
@property (nonatomic, strong) TypeHeaderView *header;
@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, assign) CGRect sectionOrigin;
@property (nonatomic, strong) SectionView *section;
@property (nonatomic, strong) NavView *nav;
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, assign) NSInteger ord; //排序，0:发布时间，1：最后回复时间
@property (nonatomic, assign) NSInteger cream; // 0 全部 1 精华帖



@end

static NSString *const headerID = @"GLheaderID";
static NSString *const CellID = @"GLCellID";

@implementation ForumTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

#pragma mark - Config UI

- (void)configUI {
    _originRect = CGRectMake(0, 0, self.view.width, Scale_Value(135));
    self.view.backgroundColor = [UIColor whiteColor];
    adjustsScrollViewInsets_NO(self.tableView, self);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.bgIV];
    [self.view addSubview:self.section];
    [self.view addSubview:self.nav];
    [self.view addSubview:self.backBtn];
}

#pragma mark - Load Data

- (void)loadData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setValue:@(0) forKey:@"limitStart"];
    [parameter setValue:@(20) forKey:@"limitNum"];
    [parameter setValue:@(self.cream) forKey:@"cream"];
    [parameter setValue:@(self.ord) forKey:@"ord"];
    [parameter setValue:self.moduleId forKey:@"moduleId"];
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_forum_Module] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            NSDictionary *data = responseOrignal[@"data"];
            self.header.modelInfo = [ModulesInfo yy_modelWithDictionary:data[@"module"]];
            Excellent *topModel = [Excellent yy_modelWithDictionary:data];
            Excellent *allModel = [Excellent yy_modelWithDictionary:data];
            self.headers = allModel.all;
            CGFloat height = Scale_Value(135) + 60 * topModel.top.count + 70;
            self.header.dataSource = topModel.top;
            self.header.height = height;
            self.section.top = height - self.section.height;
            _sectionOrigin = self.section.frame;
          
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.tableHeaderView = self.header;
                [self.bgIV setImageWithUrl:[NSURL URLWithString:PARAM_IS_NIL_ERROR(self.header.modelInfo.bgPic)] placeholder:[UIImage imageNamed:@"defaultRun1"]];
                [self.tableView reloadData];
                _section.hidden = false;
                self.nav.navTitle = self.header.modelInfo.name;
            });
            
        } else {
            
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HeaderInfoModel *model = self.headers[section];
    if (model.comment) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.model = self.headers[indexPath.section].comment;
    return  cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.headers[indexPath.section].comment;
    [model calculateCellHeight];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    HeaderInfoModel *model = [self getHeaderInfo:section];
    [model setupInfo];
    return model.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ForumContentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    header.infoModel= [self getHeaderInfo:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10.f)];
    footerView.backgroundColor = UIColorHex(#EBEBEB);
    return footerView;
}

#pragma mark - UIScrollview Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGRect rect = _originRect;
        rect.origin.y = rect.origin.y - offsetY;
        self.bgIV.frame = rect;
        
        CGRect sectionRect = _sectionOrigin;
        sectionRect.origin.y = sectionRect.origin.y - offsetY;
        if (sectionRect.origin.y < 64) {
            sectionRect.origin.y = 64;
        }
        self.section.frame = sectionRect;
        
    } else {
        CGRect rect = _originRect;
        rect.size.height = rect.size.height - offsetY;
        CGFloat proportion = Scale_Value(135) / Width;
        rect.size.width = rect.size.height / proportion;
        CGFloat originX = (rect.size.width - Width) / 2;
        rect.origin.x -= originX;
        self.bgIV.frame = rect;
        
        CGRect sectionRect = _sectionOrigin;
        sectionRect.origin.y = sectionRect.origin.y - offsetY;
        self.section.frame = sectionRect;
    }
    
    CGFloat alpha = offsetY / Scale_Value(135);
    self.nav.alpha = alpha;
}

#pragma mark - SectionViewDelegate

- (void)switchType:(NSInteger)type {
    self.cream = type;
    [self loadData];
}

- (void)loadWithRecent:(NSInteger)select {
    self.ord = select;
    [self loadData];
}

#pragma mark - Events

- (void)backAction {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark Private Method

- (HeaderInfoModel *)getHeaderInfo:(NSInteger)index {
    HeaderInfoModel *model = self.headers[index];
    return model;
}

#pragma mark - Lazy Load

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView registerClass:NSClassFromString(@"CommentCell") forCellReuseIdentifier:CellID];
        [_tableView registerClass:NSClassFromString(@"ForumContentHeader") forHeaderFooterViewReuseIdentifier:headerID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)headers {
    if (_headers == nil) {
        _headers = [NSMutableArray array];
    }
    return _headers;
}

- (NSMutableArray *)comments {
    if (_comments == nil) {
        _comments = [NSMutableArray array];
    }
    return  _comments;
}

- (BaseImageView *)bgIV {
    if (_bgIV == nil) {
        _bgIV = [[BaseImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, Scale_Value(135))];
        _bgIV.contentMode = UIViewContentModeScaleAspectFill;
        _bgIV.clipsToBounds = true;
    }
    return _bgIV;
}

- (TypeHeaderView *)header {
    if (_header == nil) {
        _header = [[TypeHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, Scale_Value(135))];
    }
    return _header;
}

- (SectionView *)section {
    if (_section == nil) {
        _section = [[SectionView alloc]init];
        _section.hidden = true;
        _section.delegate = self;
    }
    return _section;
}

- (NavView *)nav {
    if (_nav == nil) {
        _nav = [[NavView alloc]init];
        _nav.alpha = 0;
    }
    return _nav;
}

- (UIButton *)backBtn {
    if (_backBtn == nil) {
        UIImage *backImage = [[UIImage imageNamed:@"backNew"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(5, 20, 44, 44);
        [_backBtn setImage:backImage forState:UIControlStateNormal];
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
