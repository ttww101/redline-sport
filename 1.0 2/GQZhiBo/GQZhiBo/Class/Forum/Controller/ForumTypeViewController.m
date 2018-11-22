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

@interface ForumTypeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *headers;
@property (nonatomic, strong) NSMutableArray<CommentModel *> *comments;
@property (nonatomic, strong) BaseImageView *bgIV;
@property (nonatomic, strong) TypeHeaderView *header;
@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, assign) CGRect sectionOrigin;
@property (nonatomic, strong) SectionView *section;
@property (nonatomic, strong) NavView *nav;
@property (nonatomic, strong) UIButton *backBtn;




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
    self.tableView.tableHeaderView = self.header;
    [self.view addSubview:self.bgIV];
    [self.view addSubview:self.section];
    [self.view addSubview:self.nav];
    [self.view addSubview:self.backBtn];
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
            model.pics = @[@"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160503/14622764778932thumbnail.jpg", @"https://upfile.asqql.com/2009pasdfasdfic2009s305985-ts/2018-10/201810419363252338.gif", @"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160503/14622764778932thumbnail.jpg"];
        }
        
        [self.headers addObject:model];
    }
    
    for (NSInteger i = 0; i < 3; i ++) {
        CommentModel *model = [[CommentModel alloc]init];
        model.name = @"耿磊";
        model.dateStr = @"五分钟前";
        model.avaterUrl = @"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100";
        model.content = @"总结：个人来到滚球这个平台已经不知不觉中2个月了，在这里 面有了一批支持我....";
        [self.comments addObject:model];
    }
    
    NSArray *array = @[@"1", @"2", @"3"];
    CGFloat height = Scale_Value(135) + 60 * array.count + 70;
    self.header.height = height;
    self.header.dataSource = array;
     self.section.top = height - self.section.height;
    _sectionOrigin = self.section.frame;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.model = self.comments[indexPath.row];
    return  cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.comments[indexPath.row];
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
        _bgIV.image = [UIImage imageNamed:@"xuetianbg"];
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
