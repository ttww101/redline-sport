#import "ZBPlycCell.h"
#import "ZBTeamViewOfPlycCell.h"
#import "ZBPeilvViewOfPlyc.h"
#import "ZBNewZhiShuWebVC.h"
@interface ZBPlycCell()
@property (nonatomic, assign) BOOL isaddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) ZBTeamViewOfPlycCell *teamView;
@property (nonatomic, strong) ZBPeilvViewOfPlyc *peilvView;
@property (nonatomic, assign) BOOL isToFenxi;
@end
@implementation ZBPlycCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(ZBPlycModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddlayout) {
        _isaddlayout = YES;
        [self addlayout];
    }
    _teamView.type = 1;
    _teamView.model = _model;
    _peilvView.model = _model;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tofenxi)];
        [_basicView addGestureRecognizer:tap];
        [_basicView addSubview:self.teamView];
        [_basicView addSubview:self.peilvView];
    }
    return _basicView;
}
- (ZBTeamViewOfPlycCell *)teamView
{
    if (!_teamView) {
        _teamView = [[ZBTeamViewOfPlycCell alloc] init];
    }
    return _teamView;
}
- (ZBPeilvViewOfPlyc *)peilvView
{
    if (!_peilvView) {
        _peilvView = [[ZBPeilvViewOfPlyc alloc] init];
    }
    return _peilvView;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.top.equalTo(self.basicView.mas_top);
        make.size.mas_equalTo(CGSizeMake(Width, 59));
    }];
    [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.top.equalTo(self.teamView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 80));
    }];
}
- (void)tofenxi
{
    ZBNewZhiShuWebVC *listWeb = [[ZBNewZhiShuWebVC alloc] init];
    listWeb.dic = [NSDictionary dictionaryWithObjectsAndKeys:@(_model.companyId),@"companyid",_model.companyName,@"companyname",@"4",@"flagid",@(_model.oddsId),@"oddsid",@(_model.scheduleId),@"sid", nil];
    listWeb.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:listWeb animated:YES];
}
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                ZBLiveScoreModel *model = [ZBLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                model.neutrality = NO;
                ZBFenxiPageVC *fenxiVC = [[ZBFenxiPageVC alloc] init];
                fenxiVC.model = model;
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                fenxiVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            }
            _isToFenxi = NO;
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
        }];
    }else{
    }
}
@end
