//
//  YpasCell.m
//  GQapp
//
//  Created by WQ on 2017/9/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#import "TeamViewOfPlycCell.h"
#import "YpasCell.h"
#import "PeilvViewofYapsCell.h"
#import "NewZhiShuWebVC.h"

@interface YpasCell()
@property (nonatomic, assign) BOOL isaddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) TeamViewOfPlycCell *teamView;
@property (nonatomic, strong) PeilvViewofYapsCell *peilvView;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, assign) BOOL isToFenxi;

@end
@implementation YpasCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(PlycModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddlayout) {
        _isaddlayout = YES;
        [self addlayout];
    }
    
    [self.peilvView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width, 59 + _model.panProcess.count*20));
    }];

    
    _teamView.type = 2;

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
        [_basicView addSubview:self.viewLine];

    }
    return _basicView;
}

- (TeamViewOfPlycCell *)teamView
{
    if (!_teamView) {
        _teamView = [[TeamViewOfPlycCell alloc] init];
    }
    return _teamView;
}
- (PeilvViewofYapsCell *)peilvView
{
    if (!_peilvView) {
        _peilvView = [[PeilvViewofYapsCell alloc] init];
    }
    return _peilvView;
}

- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewLine;
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
        make.size.mas_equalTo(CGSizeMake(Width, 59 + _model.panProcess.count*20));
    }];
    
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 10));
    }];


}

- (void)tofenxi
{
    //    4 ,5 ,6 胜平负 亚盘  大小球
    NewZhiShuWebVC *listWeb = [[NewZhiShuWebVC alloc] init];
    
    listWeb.dic = [NSDictionary dictionaryWithObjectsAndKeys:@(_model.companyId),@"companyid",_model.companyName,@"companyname",_typeOdd == 0? @"5":@"6",@"flagid",@(_model.oddsId),@"oddsid",@(_model.scheduleId),@"sid", nil];
    
    listWeb.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:listWeb animated:YES];

//    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",_model.scheduleId] toPageindex:1 toItemIndex:1];
}
//loop 跳转分析页
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    //index 1 基本面 2 情报面 3 推荐
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                
                LiveScoreModel *model = [LiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                //从首页跳转分析页的时候不用反转
                model.neutrality = NO;
                FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];
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
