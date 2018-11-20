//
//  ForumViewController.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ForumViewController.h"

@interface ForumViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *headers;


@end

static NSString *const headerID = @"headerID";
static NSString *const CellID = @"CellID";

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

#pragma mark - Config UI

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"圈子";
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 44, 44);
    searchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [searchBtn addTarget:self action:@selector(seachAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    adjustsScrollViewInsets_NO(self.tableView, self);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Load Data

- (void)loadData {
    for (NSInteger i =0; i < 10; i ++) {
        HeaderInfoModel *model = [[HeaderInfoModel alloc]init];
        model.title = @"001马虎大 002盐湖城 《精选2串1》实弹......";
        model.message = @"总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....";
        model.dateStr = @"20分钟前";
        model.avaterUrl = @"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100";
        model.name = @"滚球越滚越红";
        model.commentsCount = @"15";
        model.seeCount = @"1000";
        if ((i % 2) == 0) {
            model.message = @"总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....总结：个人来到滚球这个平台已经不知不觉中2个月了 在这里面有了一批支持我的粉丝，我很开心！也....";
        } else {
            model.pics = @[@"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160503/14622764778932thumbnail.jpg", @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160426/14616659617000.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif"];
        }
        
        [self.headers addObject:model];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    return  cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
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

#pragma mark - Private Method

- (void)seachAction {
}

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
    }
    return _tableView;
}

- (NSMutableArray *)headers {
    if (_headers == nil) {
        _headers = [NSMutableArray array];
    }
    return _headers;
}

@end
