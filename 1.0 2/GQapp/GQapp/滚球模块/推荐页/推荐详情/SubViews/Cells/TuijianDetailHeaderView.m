//
//  TuijianDetailHeaderView.m
//  GQapp
//
//  Created by WQ_h on 16/8/3.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "TuijianDetailHeaderView.h"
#import "UserViewOfTuijianCell.h"

#import "DC_JZAPhotoVC.h"
#import "LiveScoreModel.h"

#import "FenxiPageVC.h"

@interface TuijianDetailHeaderView()<UIWebViewDelegate>
//是否添加过约束
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIView *basicView;

@property (nonatomic, strong) UserViewOfTuijianCell *headerUser;

//头像下面的线
@property (nonatomic, strong) UIView *viewLineAuthorBottom;
//赛事
@property (nonatomic, strong) UILabel *labSaishi;
//开始时间
@property (nonatomic, strong) UILabel *labbeginTime;
//期次
@property (nonatomic, strong) UILabel *labQici;

//@property (nonatomic, strong) UILabel *labCompany;

//VS 或者比分
@property (nonatomic, strong) UILabel *labVS;

//主队
@property (nonatomic, strong) UILabel *labTeamHome;
@property (nonatomic, strong) UIImageView *imageViewHome;
//客队
@property (nonatomic, strong) UILabel *labTeamGuest;
@property (nonatomic, strong) UIImageView *imageViewGuest;
//赛事下面的线
@property (nonatomic, strong) UIView *viewLineTeamBottom;


//类型:欧赔，大小球,亚盘
@property (nonatomic, strong)UILabel *labPankou;
//胜平负 大小球 或者主客
@property (nonatomic, strong) UIButton *btnWin;
@property (nonatomic, strong) UIButton *btnPing;
@property (nonatomic, strong) UIButton *btnLose;

//倍数标识
@property (nonatomic, strong) UILabel *labMultipleTitle;
//倍数符号
@property (nonatomic, strong) UIImageView *imageMultiple;
//倍数
@property (nonatomic, strong) UILabel *labMultiple;
//公司
@property (nonatomic, strong) UILabel *labCompany;
//推荐理由
@property (nonatomic, strong) UILabel *labReason;
//三个小红点
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *redView1;
@property (nonatomic, strong) UIView *redView2;


//具体内容
@property (nonatomic, strong) UILabel *labContent;

//具体内容
@property (nonatomic, strong) UIWebView *webView;
//webview中的图片
@property (nonatomic, strong) NSMutableArray *mUrlArray;

//发布日期
@property (nonatomic, strong) UILabel *labCreatTime;
//反对按钮
@property (nonatomic, strong) UIButton *btnZan;
//反对数
@property (nonatomic, strong) UILabel *labZanNum;
//点赞按钮
@property (nonatomic, strong) UIButton *btnNoZan;
//点赞数
@property (nonatomic, strong) UILabel *labNoZanNum;
//举报按钮
@property (nonatomic, strong) UIButton *btnComment;
//评论数
@property (nonatomic, strong) UILabel *labConmmentNum;
//赢的情况
@property (nonatomic, strong) UIImageView *imageViewWin;
//举报
@property (nonatomic, strong) UIButton *btnReport;
//底部的分割线
@property (nonatomic, strong) UIView *viewLineBasicViewBottom;
//去赛事页面
@property (nonatomic, strong)UIButton *btnToBiFen;

@property (nonatomic, strong)UIButton *allBtn;
//是否正在请求跳转分析页的接口
@property (nonatomic, assign) BOOL isToFenxi;



@property (nonatomic, strong) UILabel *labcontentPart;
@property (nonatomic, strong) UIImageView *imgcontentPart;
@property (nonatomic, strong) UIImageView *imghidecontent;

@property (nonatomic, strong) UILabel *labhidecontentPartDetail;

@property (nonatomic, strong) UILabel *labcontentPartDetail;
@property (nonatomic, strong) UILabel *labMoney;

@end
@implementation TuijianDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setModel:( TuijiandatingModel*)model
{
    _model = model;
    
    if (_model.see) {
        _type = TuijianDetailHeaderViewShowContent;
       
    }else{
        _type = TuijianDetailHeaderViewHideContent;

    }

    [self.contentView addSubview:self.basicView];
    
    
    if (!_didSetupConstraints) {
        _didSetupConstraints = YES;
        [self addAutoLayoutToCell];
    }

    
    if (isNUll(_model.userinfo) || [_model.userinfo isEqualToString:@" "]) {
        [self.headerUser mas_updateConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(58);
        }];

    }else{
    
        [self.headerUser mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(82);
        }];

    }
    
    [_headerUser setValueWithUserTitle:_model.nickname Pic:_model.pic ArrTitles:_model.medals Remark:_model.arrUsermark  Win:_model.win_rate Profite:_model.profit_rate Round:[NSString stringWithFormat:@"%ld",(long)_model.recommend_count] Fans:[NSString stringWithFormat:@"%ld",(long)_model.follower_count] Userid:_model.user_id colorType:2 cellType:typeTuijianCellTuijianDetail readCount:[NSString stringWithFormat:@"%ld",_model.readCount] dayRange:_model.dayRange WithModel:_model];

    
    
    if (_model.MatchState == -1) {
        _labVS.font = [UIFont boldSystemFontOfSize:fontSize28];
        _labVS.textColor = redcolor;
        _labVS.text = [NSString stringWithFormat:@"%ld : %ld",(long)_model.HomeScore,(long)_model.GuestScore];
    }
//    else if (_model.MatchState == 1 ||_model.MatchState == 2 ||_model.MatchState == 3 ||_model.MatchState == 4) {
//        _labVS.font = [UIFont boldSystemFontOfSize:fontSize28];
//        _labVS.textColor = green2Color;
//        _labVS.text = [NSString stringWithFormat:@"%ld : %ld",(long)_model.HomeScore,(long)_model.GuestScore];
//    }
    else {
        _labVS.font = font28;
        _labVS.textColor = color99;
        _labVS.text = @"vs";
        
    }

    

    _labSaishi.text = _model.Name_JS;
    _labSaishi.textColor = [Methods getColor:_model.leagueColor];

    _labbeginTime.text = [NSString stringWithFormat:@"%@",_model.MatchTime];
    
    
    if (_model.HomeTeam.length>6) {
        _labTeamHome.text = [_model.HomeTeam substringToIndex:6];

    }else{
        _labTeamHome.text = _model.HomeTeam;

    }
    if (_model.GuestTeam.length>6) {
        _labTeamGuest.text = [_model.GuestTeam substringToIndex:6];

    }else{
        _labTeamGuest.text = _model.GuestTeam;

    }
    [_imageViewHome sd_setImageWithURL:[NSURL URLWithString:url_imageTeam((long)model.HomeTeamID)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
    [_imageViewGuest sd_setImageWithURL:[NSURL URLWithString:url_imageTeam((long)model.GuestTeamID)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];

  
    if (_model.amount == 0) {
        _labMoney.text = @"";
        _labMoney.textColor = greencolor;
    }else{
        _labMoney.textColor = redcolor;
        
        _labMoney.text = [NSString stringWithFormat:@"%ld球币",_model.amount/100];
        
        
//        _labMoney.attributedText = [Methods withContent:_labMoney.text WithColorText:@"球币" textColor:color33 strFont:font12];
    }
//    隐藏
//    _labMoney.text = @"";

    NSString *space = @"";
    if (isOniPhone4 ||  isOniPhone5) {
        space = @"          ";
    }else if (isOniphone6){
        space = @"              ";

    }else if (isOniphone6p){
    
        space = @"                  ";

    }
    if (_model.spf.count>0) {//欧赔

        
        _labPankou.text = @"胜平负推荐";
        NSArray* arr = _model.spf;
        [_btnWin setTitle:[NSString stringWithFormat:@"胜%@%@",space,[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [_btnPing setTitle:[NSString stringWithFormat:@"平%@%@",space,[arr objectAtIndex:1]] forState:UIControlStateNormal];
        [_btnLose setTitle:[NSString stringWithFormat:@"负%@%@",space,[arr objectAtIndex:2]] forState:UIControlStateNormal];
        
        [_btnWin setAttributedTitle:[Methods withContent:_btnWin.currentTitle WithContColor:color66 WithContentFont:font12 WithText:@"胜" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];
        [_btnPing setAttributedTitle:[Methods withContent:_btnPing.currentTitle WithContColor:color66 WithContentFont:font12 WithText:@"平" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];
        [_btnLose setAttributedTitle:[Methods withContent:_btnLose.currentTitle WithContColor:color66 WithContentFont:font12 WithText:@"负" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];
        
        
        [_btnWin setAttributedTitle:[Methods withContent:_btnWin.currentTitle WithContColor:_model.see? [UIColor whiteColor]:color33 WithContentFont:font12 WithText:@"胜" WithTextColor:_model.see? [UIColor whiteColor]:color33 WithTextFont:font14] forState:UIControlStateSelected];
        [_btnPing setAttributedTitle:[Methods withContent:_btnPing.currentTitle WithContColor:_model.see? [UIColor whiteColor]:color33 WithContentFont:font12 WithText:@"平" WithTextColor:_model.see? [UIColor whiteColor]:color33 WithTextFont:font14] forState:UIControlStateSelected];
        [_btnLose setAttributedTitle:[Methods withContent:_btnLose.currentTitle WithContColor:_model.see? [UIColor whiteColor]:color33 WithContentFont:font12 WithText:@"负" WithTextColor:_model.see? [UIColor whiteColor]:color33 WithTextFont:font14] forState:UIControlStateSelected];
       
//        [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateNormal];
//        if(!_model.see) {
//            
//            [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected];
//        }
//        [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected];
        _model.see ? ([_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);
        _model.see ? ([_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);
        _model.see ? ([_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);

        
    }else if (_model.ya.count>0){//亚盘
       

        _labPankou.text = @"让球推荐";
        NSArray* arr = _model.ya;
        [_btnWin setTitle:[NSString stringWithFormat:@"主%@%@",space,[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [_btnPing setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
        [_btnLose setTitle:[NSString stringWithFormat:@"客%@%@",space,[arr objectAtIndex:2]] forState:UIControlStateNormal];
        
        
        [_btnWin setAttributedTitle:[Methods withContent:_btnWin.currentTitle WithContColor:color66 WithContentFont:font12 WithText:@"主" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];

        [_btnLose setAttributedTitle:[Methods withContent:_btnLose.currentTitle WithContColor:color66 WithContentFont:font12 WithText:@"客" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];
        
        [_btnWin setAttributedTitle:[Methods withContent:_btnWin.currentTitle WithContColor:_model.see? [UIColor whiteColor]:color33 WithContentFont:font12 WithText:@"主" WithTextColor:_model.see? [UIColor whiteColor]:color33 WithTextFont:font14] forState:UIControlStateSelected];
        [_btnLose setAttributedTitle:[Methods withContent:_btnLose.currentTitle WithContColor:_model.see? [UIColor whiteColor]:color33 WithContentFont:font12 WithText:@"客" WithTextColor:_model.see? [UIColor whiteColor]:color33 WithTextFont:font14] forState:UIControlStateSelected];
        [_btnPing setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
//        if(!_model.see) {
//            
//            [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected];
//        }
//        [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected];
        _model.see ? ([_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);
        _model.see ? ([_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);
        _model.see ? ([_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);

        
    }else if (_model.dx.count>0){//判断大小球
       
        _labPankou.text = @"大小球推荐";
        NSArray* arr = _model.dx;
        [_btnWin setTitle:[NSString stringWithFormat:@"大%@%@",space,[arr objectAtIndex:0]] forState:UIControlStateNormal];
        [_btnPing setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
        
        [_btnLose setTitle:[NSString stringWithFormat:@"小%@%@",space,[arr objectAtIndex:2]] forState:UIControlStateNormal];
        
        
        
        [_btnWin setAttributedTitle:[Methods withContent:_btnWin.currentTitle WithContColor:color66 WithContentFont:font12 WithText:@"大" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];
        
        [_btnLose setAttributedTitle:[Methods withContent:_btnLose.currentTitle WithContColor:color66 WithContentFont:font12 WithText:@"小" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];
        
        [_btnWin setAttributedTitle:[Methods withContent:_btnWin.currentTitle WithContColor:_model.see? [UIColor whiteColor]:color33 WithContentFont:font12 WithText:@"大" WithTextColor:_model.see? [UIColor whiteColor]:color33 WithTextFont:font14] forState:UIControlStateSelected];
        [_btnLose setAttributedTitle:[Methods withContent:_btnLose.currentTitle WithContColor:_model.see? [UIColor whiteColor]:color33 WithContentFont:font12 WithText:@"小" WithTextColor:_model.see? [UIColor whiteColor]:color33 WithTextFont:font14] forState:UIControlStateSelected];

        [_btnPing setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        _model.see == 1? ([_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);
        _model.see ? ([_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);
        _model.see ? ([_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected]):([_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected]);

//        if(!_model.see) {
//            
//            [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected];
//        }
//        [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected];

    }
    
    switch (_model.choice) {
        case 3:
        {
            _btnWin.selected = YES;
            _btnPing.selected = NO;
            _btnLose.selected = NO;
        }
            break;
        case 1:
        {
            _btnWin.selected = NO;
            _btnPing.selected = YES;
            _btnLose.selected = NO;
        }
            break;
        case 0:
        {
            _btnWin.selected = NO;
            _btnPing.selected = NO;
            _btnLose.selected = YES;
        }
            break;
        default:
            break;
    }

    
    
    _labMultipleTitle.text = @"注码:";
    _imageMultiple.image = [UIImage imageNamed:@"multiple"];
    if (_model.multiple == 0 || _model.multiple == 1) {
        _labMultiple.text = @"均注";
        
    }else{
        _labMultiple.text = [NSString stringWithFormat:@"%ld倍",(long)_model.multiple];
    }
    _labReason.text = @"推荐理由";
//    _labContent.text = _model.content;
    

    _labCreatTime.text = [NSString stringWithFormat:@"发布于%@",[Methods timeToNowWith:_model.create_time]];
    
//    _labZanNum.text = @"";
//    
//    _labNoZanNum.text = @"";
//    _labConmmentNum.text = @"";
    
//    [_btnComment setTitle:[NSString stringWithFormat:@"共%ld人打赏",_model.like_count] forState:UIControlStateNormal];
    
    
    
    if (_type == TuijianDetailHeaderViewShowContent) {
        if (_model.contentInfo!= nil && ![_model.contentInfo isEqualToString:@""]) {
            
            [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(_webViewHight).priority(750);
            }];
            
            NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "*{padding:0;margin:0;}p{line-height:22px;width:100%%; padding-bottom:0px;float:left;}"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "<script type='text/javascript'>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                               " $img[p].style.maxWidth = '100%%';\n"
                               "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>%@"
                               "</body>"
                               "</html>",_model.contentInfo];
            
            [self.webView loadHTMLString:htmls baseURL:nil];
            
        }else{
            [_labContent setAttributedText:[Methods setTextStyleWithString:_model.content WithLineSpace:5 WithHeaderIndent:0]];
        }
 
    }else{
        _labcontentPart.text =_model.content;

    }
    
    
    
    if (_model.result!= nil) {
        switch ([_model.result integerValue]) {
            case 0:
            {
                _imageViewWin.image = [UIImage imageNamed:@"wuxiao"];
            }
                break;
            case 1:
            {
                _imageViewWin.image = [UIImage imageNamed:@"winhalf"];
            }
                break;
                
            case 2:
            {
                _imageViewWin.image = [UIImage imageNamed:@"win"];
            }
                break;
                
            case -1:
            {
                _imageViewWin.image = [UIImage imageNamed:@"losehalf"];
            }
                break;
                
            case -2:
            {
                _imageViewWin.image = [UIImage imageNamed:@"lose"];
            }
                break;
            case -3:
            {
                _imageViewWin.image = [UIImage imageNamed:@"cheDan"];
            }
                break;

            case 10:
            {
                _imageViewWin.image = [UIImage imageNamed:@"wuxiaoNew"];
            }
                break;
                
            default:
                break;
        }
        
    }else{
        _imageViewWin.image = [UIImage imageNamed:@"clear"];
        
    }



}

- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        _basicView.backgroundColor = [UIColor whiteColor];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTuijianDetail)];
        [_basicView addSubview:self.headerUser];
        [_basicView addSubview:self.viewLineAuthorBottom];
        [_basicView addSubview:self.labSaishi];
        [_basicView addSubview:self.labbeginTime];
        [_basicView addSubview:self.labQici];
        [_basicView addSubview:self.imageViewHome];
        [_basicView addSubview:self.labTeamHome];
        [_basicView addSubview:self.labVS];
        [_basicView addSubview:self.imageViewGuest];
        [_basicView addSubview:self.labTeamGuest];
        
        [_basicView addSubview:self.btnToBiFen];
        [_basicView addSubview:self.allBtn];
        
        [_basicView addSubview:self.viewLineTeamBottom];
        [_basicView addSubview:self.labPankou];
        [_basicView addSubview:self.labMoney];

        [_basicView addSubview:self.btnWin];
        [_basicView addSubview:self.btnPing];
        [_basicView addSubview:self.btnLose];
        [_basicView addSubview:self.labReason];

        
        
        
        if (_type == TuijianDetailHeaderViewShowContent) {
            
            
            [_basicView addSubview:self.labMultipleTitle];
            [_basicView addSubview:self.imageMultiple];
            [_basicView addSubview:self.labMultiple];
            [_basicView addSubview:self.labCompany];
            [_basicView addSubview:self.redView];
            [_basicView addSubview:self.redView1];
            [_basicView addSubview:self.redView2];

            
            [_basicView addSubview:self.imageViewWin];
            [_basicView addSubview:self.labContent];
            [_basicView addSubview:self.webView];
            [_basicView addSubview:self.labCreatTime];
            [_basicView addSubview:self.labConmmentNum];
            [_basicView addSubview:self.btnComment];
            [_basicView addSubview:self.labNoZanNum];
            [_basicView addSubview:self.btnNoZan];
            [_basicView addSubview:self.labZanNum];
            [_basicView addSubview:self.btnZan];

        }else{
            [_basicView addSubview:self.imageViewWin];
            [_basicView addSubview:self.labcontentPart];
            [_basicView addSubview:self.imghidecontent];
            [_basicView addSubview:self.imgcontentPart];
            [_basicView addSubview:self.labcontentPartDetail];
            [_basicView addSubview:self.labhidecontentPartDetail];
            [_basicView addSubview:self.labCreatTime];

        }
        
        
        
        
        [_basicView addSubview:self.viewLineBasicViewBottom];

    }
    return _basicView;
}

- (UserViewOfTuijianCell *)headerUser
{
    if (!_headerUser) {
        _headerUser = [[UserViewOfTuijianCell alloc] init];
    }
    return _headerUser;
}


- (UIView *)viewLineAuthorBottom
{
    if (!_viewLineAuthorBottom) {
        _viewLineAuthorBottom = [[UIView alloc] init];
        _viewLineAuthorBottom.backgroundColor = colorCellLine;
    }
    return _viewLineAuthorBottom;
}
- (UILabel *)labSaishi
{
    if (!_labSaishi) {
        _labSaishi = [[UILabel alloc] init];
        _labSaishi.font = font10;
        _labSaishi.numberOfLines = 0;
        _labSaishi.textColor = color33;
        _labSaishi.textAlignment = NSTextAlignmentCenter;

    }
    return _labSaishi;
}
- (UILabel *)labbeginTime
{
    if (!_labbeginTime) {
        _labbeginTime = [[UILabel alloc] init];
        _labbeginTime.font = font10;
        _labbeginTime.textColor = color66;
        
    }
    return _labbeginTime;
}
- (UILabel *)labQici
{
    if (!_labQici) {
        _labQici = [[UILabel alloc] init];
        _labQici.font = font10;
        _labQici.textColor = color99;

    }
    return _labQici;
}
- (UIImageView *)imageViewHome
{
    if (!_imageViewHome) {
        _imageViewHome = [[UIImageView alloc] init];
        _imageViewHome.image = [UIImage imageNamed:@"red"];
    }
    return _imageViewHome;
}
- (UILabel *)labTeamHome
{
    if (!_labTeamHome) {
        _labTeamHome = [[UILabel alloc] init];
        _labTeamHome.textColor = color33;
        _labTeamHome.font = font12;
        _labTeamHome.textAlignment = NSTextAlignmentCenter;
    }
    return _labTeamHome;
}

- (UILabel *)labVS
{
    if (!_labVS) {
        _labVS = [[UILabel alloc] init];
        _labVS.font = font28;
        _labVS.textColor = redcolor;
    }
    return _labVS;
}
- (UIImageView *)imageViewGuest
{
    if (!_imageViewGuest) {
        _imageViewGuest = [[UIImageView alloc] init];
        _imageViewGuest.image = [UIImage imageNamed:@"red"];

    }
    return _imageViewGuest;
}
- (UILabel *)labTeamGuest
{
    if (!_labTeamGuest) {
        _labTeamGuest = [[UILabel alloc] init];
        _labTeamGuest.textColor = color33;
        _labTeamGuest.font = font12;
        _labTeamGuest.textAlignment = NSTextAlignmentCenter;
    }
    return _labTeamGuest;
}
- (UIButton *)btnToBiFen{
    if (!_btnToBiFen) {
        _btnToBiFen = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnToBiFen setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btnToBiFen addTarget:self action:@selector(btnToBiFenClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnToBiFen;
}

- (UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn addTarget:self action:@selector(btnToBiFenClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _allBtn;
}
- (void)btnToBiFenClick{
    
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        
        return;
    }

    
    
//    AnalysisVC *anVC = [[AnalysisVC alloc] init];

    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(3) forKey:@"flag"];
    [parameter setObject:@((long)_model.match_id) forKey:@"sid"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,@"/match"] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        

        LiveScoreModel *scoremodel = [LiveScoreModel entityFromDictionary:responseOrignal[@"data"]];
        FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];

        fenxiVC.model = scoremodel;
        if (scoremodel.matchstate == 1 || scoremodel.matchstate == 2 ||scoremodel.matchstate == 3 ||scoremodel.matchstate == 4 ||scoremodel.matchstate == -1 ) {
            fenxiVC.currentIndex = 4;
        }

        fenxiVC.hidesBottomBarWhenPushed = YES;

        [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
        
        _isToFenxi = NO;
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        NSLog(@"%@",error);
        _isToFenxi = NO;

    }];
    
    
    

    
    
}
- (UIView *)viewLineTeamBottom
{
    if (!_viewLineTeamBottom) {
        _viewLineTeamBottom = [[UIView alloc] init];
        _viewLineTeamBottom.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewLineTeamBottom;
}
- (UILabel *)labPankou
{
    if (!_labPankou) {
        _labPankou = [[UILabel alloc] init];
        _labPankou.font = font12;
        _labPankou.textColor = color66;
    }
    return _labPankou;
}

- (UIButton *)btnWin
{
    if (!_btnWin) {
        _btnWin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWin.userInteractionEnabled = NO;
        _btnWin.titleLabel.font = font14;
        _btnWin.layer.cornerRadius = 3;
        _btnWin.layer.masksToBounds = YES;
        [_btnWin setTitleColor:color33 forState:UIControlStateNormal];
        [_btnWin setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
       
        [_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateNormal];
//        if (_model.see) {
        
//            [_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected];
//        }
//        [_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected];

    }
    return _btnWin;
}

- (UIButton *)btnPing
{
    if (!_btnPing) {
        _btnPing = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPing.userInteractionEnabled = NO;
        _btnPing.layer.cornerRadius = 3;
        _btnPing.layer.masksToBounds = YES;

        _btnPing.titleLabel.font = font14;
        [_btnPing setTitleColor:color33 forState:UIControlStateNormal];
        [_btnPing setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateNormal];
//        if (_model.see) {
        
//            [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected];
//        }
//        [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected];
    }
    return _btnPing;
}
- (UIButton *)btnLose
{
    if (!_btnLose) {
        _btnLose = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLose.userInteractionEnabled = NO;
        _btnLose.layer.cornerRadius = 3;
        _btnLose.layer.masksToBounds = YES;

        _btnLose.titleLabel.font = font14;
        [_btnLose setTitleColor:color33 forState:UIControlStateNormal];
        [_btnLose setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateNormal];
//        if (_model.see) {
        
//            [_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected2"] forState:UIControlStateSelected];
//        }
//        [_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateSelected];
    }
    return _btnLose;
}
- (UILabel *)labMultipleTitle
{
    if (!_labMultipleTitle) {
        _labMultipleTitle = [[UILabel alloc] init];
        _labMultipleTitle.textColor = color66;
        _labMultipleTitle.font = font12;
    };
    return _labMultipleTitle;
}
- (UIImageView *)imageMultiple
{
    if (!_imageMultiple) {
        _imageMultiple = [[UIImageView alloc] init];
        _imageMultiple.image = [UIImage imageNamed:@"red"];
    }
    return _imageMultiple;
}

- (UILabel *)labMultiple
{
    if (!_labMultiple) {
        _labMultiple = [[UILabel alloc] init];
        _labMultiple.textColor = color33;
        _labMultiple.font = font12;
    }
    return _labMultiple;
}

- (UILabel *)labCompany
{
    if (!_labCompany) {
        _labCompany = [[UILabel alloc] init];
        _labCompany.textColor = color27;
        _labCompany.font = font13;
    }
    return _labCompany;

}
- (UILabel *)labReason
{
    if (!_labReason) {
        _labReason = [[UILabel alloc] init];
        _labReason.textColor = color66;
        _labReason.font = font12;
    }
    return _labReason;
    
}
- (UIView *)redView
{
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = colorDD;
    }
    return _redView;
}
- (UIView *)redView1
{
    if (!_redView1) {
        _redView1 = [[UIView alloc] init];
        _redView1.backgroundColor = colorDD;
    }
    return _redView1;
}
- (UIView *)redView2
{
    if (!_redView2) {
        _redView2 = [[UIView alloc] init];
        _redView2.backgroundColor = colorDD;
    }
    return _redView2;
}


- (UILabel *)labContent
{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.font = font14;
        _labContent.textColor = color52;
        _labContent.numberOfLines = 0;
    }
    return _labContent;
}
- (UILabel *)labcontentPart
{
    if (!_labcontentPart) {
        _labcontentPart = [[UILabel alloc] init];
        _labcontentPart.font = font14;
        _labcontentPart.textColor = color33;
        _labcontentPart.numberOfLines = 1;
    }
    return _labcontentPart;
}
- (UILabel *)labcontentPartDetail
{
    if (!_labcontentPartDetail) {
        _labcontentPartDetail = [[UILabel alloc] init];
        _labcontentPartDetail.backgroundColor = colorTableViewBackgroundColor;
        _labcontentPartDetail.font = font12;
        _labcontentPartDetail.textColor = color66;
        _labcontentPartDetail.textAlignment = NSTextAlignmentCenter;
        _labcontentPartDetail.text = @"以上内容仅代表分析师个人观点，仅供浏览和参考";
    }
    return _labcontentPartDetail;
}
- (UILabel *)labhidecontentPartDetail
{
    if (!_labhidecontentPartDetail) {
        _labhidecontentPartDetail = [[UILabel alloc] init];
        _labhidecontentPartDetail.font = font12;
        _labhidecontentPartDetail.textColor = color33;
        _labhidecontentPartDetail.textAlignment = NSTextAlignmentCenter;
        _labhidecontentPartDetail.text = @"投注内容和推荐理由，付费后才能查看";
    }
    return _labhidecontentPartDetail;
}
- (UIImageView *)imgcontentPart
{
    if (!_imgcontentPart) {
        _imgcontentPart = [[UIImageView alloc] init];
        _imgcontentPart.image = [UIImage imageNamed:@"hideImge"];
    }
    return _imgcontentPart;
}
- (UIImageView *)imghidecontent
{
    if (!_imghidecontent) {
        _imghidecontent = [[UIImageView alloc] init];
        _imghidecontent.image = [UIImage imageNamed:@"hideContent"];
    }
    return _imghidecontent;
}
- (UILabel *)labMoney{
    if (!_labMoney) {
        _labMoney = [[UILabel alloc] init];
        _labMoney.font = BoldFont4(fontSize12);
        _labMoney.textColor  = greencolor;
        _labMoney.text = @"免费";
        
    }
    return _labMoney;
    
    
}
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.opaque = NO;
//                _webView.scalesPageToFit = YES;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        //        NSLog(@"%@",_url);
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
        self.webView.scrollView.backgroundColor = [UIColor whiteColor];
        self.webView.scrollView.showsVerticalScrollIndicator = NO;
        self.webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSInteger index = [_mUrlArray indexOfObject:path];
        
        DC_JZAPhotoVC *album = [[DC_JZAPhotoVC alloc] init];
        
        album.imgArr = _mUrlArray;//可以是图片的url字符串数组，亦可以是UIImage
        
        album.currentIndex = index; //下标
        
        [APPDELEGATE.customTabbar presentToViewController:album animated:YES completion:^{
            
        }];
        
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    

    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    _mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    
    if ([[_mUrlArray lastObject] isEqualToString:@""]) {
        [_mUrlArray removeLastObject];
        
    }
    
    //给html上的图片添加点击事件
    [self.webView stringByEvaluatingJavaScriptFromString:@"function assignImageClickAction(){var imgs=document.getElementsByTagName('img');var length=imgs.length;for(var i=0;i<length;i++){img=imgs[i];img.onclick=function(){window.location.href='image-preview:'+this.src}}}"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"assignImageClickAction();"];
    
    
    
//        让webview里面的图片自适应，尽可能的多循环几次，防止有图片没有没循环到
//    for (int i = 0; i<_mUrlArray.count; i++) {
//        NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.width = '100%%'",i];
//        [self.webView stringByEvaluatingJavaScriptFromString:str];
//    }
    
    //设置网页的内容
    //字体大小
    NSString *textSize = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%d",14];
    [webView stringByEvaluatingJavaScriptFromString:textSize];
//
//    //字体颜色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#333'"];
    //页面背景色
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
    
    
    
    //webview的内容高度
    //    CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
    
}


- (UILabel *)labCreatTime
{
    if (!_labCreatTime) {
        _labCreatTime = [[UILabel alloc] init];
//        _labCreatTime.backgroundColor = redcolor;
        _labCreatTime.font = font12;
        _labCreatTime.textColor = color66;
    }
    return _labCreatTime;
}

- (UILabel *)labConmmentNum
{
    if (!_labConmmentNum) {
        _labConmmentNum = [[UILabel alloc] init];
        _labConmmentNum.font = font10;
        _labConmmentNum.textColor = grayColor3;
    }
    return _labConmmentNum;
}
//打赏人数
- (UIButton *)btnComment
{
    if (!_btnComment) {
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.titleLabel.font = font12;
        [_btnComment setTitleColor:color33 forState:UIControlStateNormal];
        _btnComment.userInteractionEnabled = NO;
        [_btnComment addTarget:self action:@selector(report) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnComment;
}
- (UILabel *)labNoZanNum
{
    if (!_labNoZanNum) {
        _labNoZanNum = [[UILabel alloc] init];
        _labNoZanNum.font = font12;
        _labNoZanNum.textColor = color74;
        
    }
    return _labNoZanNum;
}

//打赏按钮
- (UIButton *)btnNoZan
{
    if (!_btnNoZan) {
        _btnNoZan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnNoZan.titleLabel.font = font16;
        [_btnNoZan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNoZan.backgroundColor = redcolor;
        _btnNoZan.layer.cornerRadius = 22;
        _btnNoZan.layer.masksToBounds = YES;
//        [_btnNoZan setTitle:@"打赏" forState:UIControlStateNormal];
        _btnNoZan.tag = 1;

        [_btnNoZan addTarget:self action:@selector(addLikedHated:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnNoZan;
}

- (UILabel *)labZanNum
{
    if (!_labZanNum) {
        _labZanNum = [[UILabel alloc] init];
        _labZanNum.font = font12;
        _labZanNum.textColor = color34AAF2;
    }
    return _labZanNum;
}
//打赏的话
- (UIButton *)btnZan
{
    if (!_btnZan) {
        _btnZan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnZan.titleLabel.font = font12;
        [_btnZan setTitleColor:colorCC forState:UIControlStateNormal];
        _btnZan.tag = 0;
//        [_btnZan setTitle:@"您的打赏，是对我最大的鼓励" forState:UIControlStateNormal];
        _btnZan.userInteractionEnabled = NO;
        [_btnZan addTarget:self action:@selector(addLikedHated:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnZan;
}
- (UIImageView *)imageViewWin
{
    if (!_imageViewWin) {
        _imageViewWin = [[UIImageView alloc] init];
    }
    return _imageViewWin;
}
- (UIView *)viewLineBasicViewBottom
{
    if (!_viewLineBasicViewBottom) {
        _viewLineBasicViewBottom = [[UIView alloc] init];
        _viewLineBasicViewBottom.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewLineBasicViewBottom;
}



- (void)addAutoLayoutToCell
{
    
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-0);
        make.bottom.equalTo(self.contentView).offset(-0);
    } ];
    
    [self.headerUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top);
        make.left.equalTo(self.basicView.mas_left);
        make.right.equalTo(self.basicView.mas_right);
        make.height.mas_equalTo(82);
    }];
    
    
    
    
    
    
    [self.labSaishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.top.equalTo(self.headerUser.mas_bottom).offset(22);
        
    }];

    
    
    
    
//    [self.labQici mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.headerUser.mas_bottom).offset(22);
//        make.centerX.equalTo(self.basicView.mas_centerX);
//    }];
    [self.labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSaishi.mas_bottom).offset(4.5);
        make.centerX.equalTo(self.basicView.mas_centerX);
        
    }];

    [self.labbeginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.top.equalTo(self.labVS.mas_bottom).offset(3.5);

//        make.centerY.equalTo(self.labQici.mas_centerY);
    }];
 
    
    [self.imageViewHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerUser.mas_bottom).offset(24);
        make.left.equalTo(self.basicView.mas_left).offset(42);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.imageViewGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerUser.mas_bottom).offset(24);
        make.right.equalTo(self.basicView.mas_right).offset(-42);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];

    [self.labTeamHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageViewHome.mas_centerX).offset(0);
        make.top.equalTo(self.imageViewHome.mas_bottom).offset(11.5);
    }];
    [self.labTeamGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageViewGuest.mas_centerX).offset(0);
        make.top.equalTo(self.imageViewGuest.mas_bottom).offset(11.5);
    }];

    
//     [self.btnToBiFen mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.basicView.mas_right).offset(-10);
//        make.top.equalTo(self.imageViewGuest.mas_top).offset(25);
//        make.width.mas_equalTo(10);
//        make.height.mas_equalTo(20);
//        
//    }];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.right.equalTo(self.basicView.mas_right);
        make.top.equalTo(self.headerUser.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(Width, 110));
    }];

    
    
    
    [self.viewLineTeamBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTeamHome.mas_bottom).offset(17.5);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(10);
    }];
    
    [self.labPankou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.viewLineTeamBottom.mas_top).offset(21.5);
    }];
    
    [self.labMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labPankou.mas_right).offset(15);
        make.centerY.equalTo(self.labPankou.mas_centerY);
    }];

    [self.btnWin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labPankou.mas_bottom).offset(11.5);
        make.width.mas_equalTo((Width - 15*2-10*2)/3);
        make.height.mas_equalTo(44);
    }];
    [self.btnPing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnWin.mas_right).offset(10);
        make.centerY.equalTo(self.btnWin.mas_centerY);
        make.width.equalTo(self.btnWin.mas_width);
        make.height.mas_equalTo(44);

    }];
    [self.btnLose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnPing.mas_right).offset(10);
        make.centerY.equalTo(self.btnWin.mas_centerY);
        make.width.equalTo(self.btnWin.mas_width);
        make.height.mas_equalTo(44);

    }];
    
    
    [self.viewLineAuthorBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnWin.mas_bottom).offset(29);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewLineAuthorBottom.mas_centerY).offset(20);
        make.centerX.equalTo(self.viewLineAuthorBottom.mas_centerX);
    }];

    
    if (_type == TuijianDetailHeaderViewShowContent) {
        
        
        
        

        
//        [self.labCompany mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.labPankou.mas_left);
//            make.top.equalTo(self.labPankou.mas_top).offset(0);
//        }];

        [self.labMultipleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.top.equalTo(self.viewLineAuthorBottom.mas_bottom).offset(21.5);
        }];
        [self.imageMultiple mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labMultipleTitle.mas_left).offset(0);
            make.centerY.equalTo(self.labMultipleTitle.mas_centerY);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        [self.labMultiple mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labMultipleTitle.mas_right).offset(0);
            make.centerY.equalTo(self.labMultipleTitle.mas_centerY);
        }];
        
//        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.basicView.mas_left).offset(15);
//            make.centerY.equalTo(self.labPankou.mas_centerY);
//            make.width.mas_equalTo(0);
//            make.height.mas_equalTo(0);
//        }];
        

        [self.labReason mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labMultiple.mas_bottom).offset(6.5);
            make.left.equalTo(self.basicView.mas_left).offset(15);
            
        }];

        
        
        [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.top.equalTo(self.labReason.mas_bottom).offset(6.5);
            make.right.equalTo(self.basicView.mas_right).offset(-15);
        }];
        
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.top.equalTo(self.labReason.mas_bottom).offset(6.5);
            make.right.equalTo(self.basicView.mas_right).offset(-15);
            make.height.mas_equalTo(0).priority(750);
        }];
        
        
        
        [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.basicView.mas_right).offset(-15);
            make.top.equalTo(self.webView.mas_bottom).offset(15.5);
        }];
        
        
        
//        [self.labZanNum mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.btnZan.mas_bottom).offset(10);
//            make.centerX.equalTo(self.btnZan.mas_centerX).offset(0);
//        }];
//        
//        
//        
//        [self.labNoZanNum mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.btnNoZan.mas_bottom).offset(10);
//            make.centerX.equalTo(self.btnNoZan.mas_centerX).offset(0);
//        }];
//        
//        
//        
//        
//        [self.labConmmentNum mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.basicView.mas_right).offset(-15);
//            make.bottom.equalTo(self.labCreatTime.mas_bottom);
//        }];
//        
//        
//        
        
        
        
        
        //    //打赏的话
        //    [self.btnZan mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
        //        make.top.equalTo(self.labCreatTime.mas_bottom).offset(25);
        //    }];
        //    //    打赏的话两边的线
        //    [self.redView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self.basicView.mas_left).offset(15);
        //        make.centerY.equalTo(self.btnZan.mas_centerY);
        //        make.right.equalTo(self.btnZan.mas_left).offset(-17);
        //        make.height.mas_equalTo(0.5);
        //
        //    }];
        //    [self.redView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.right.equalTo(self.basicView.mas_right).offset(-15);
        //        make.centerY.equalTo(self.btnZan.mas_centerY);
        //        make.left.equalTo(self.btnZan.mas_right).offset(17);
        //        make.height.mas_equalTo(0.5);
        //
        //    }];
        //
        //    //打赏按钮
        //    [self.btnNoZan mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
        //        make.top.equalTo(self.btnZan.mas_bottom).offset(20);
        //        make.width.mas_equalTo(190);
        //        make.height.mas_equalTo(44);
        //
        //    }];
        //    //多少人打赏
        //    [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
        //        make.top.equalTo(self.btnNoZan.mas_bottom).offset(15);
        //    }];
        
        
        
        
        
//        //打赏的话
//        [self.btnZan mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
//            make.top.equalTo(self.labCreatTime.mas_bottom).offset(0);
//        }];
//        //    打赏的话两边的线
//        [self.redView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.basicView.mas_left).offset(15);
//            make.centerY.equalTo(self.btnZan.mas_centerY);
//            make.right.equalTo(self.btnZan.mas_left).offset(-17);
//            make.height.mas_equalTo(0);
//            
//        }];
//        [self.redView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.basicView.mas_right).offset(-15);
//            make.centerY.equalTo(self.btnZan.mas_centerY);
//            make.left.equalTo(self.btnZan.mas_right).offset(17);
//            make.height.mas_equalTo(0);
//            
//        }];
//        
//        //打赏按钮
//        [self.btnNoZan mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
//            make.top.equalTo(self.btnZan.mas_bottom).offset(0);
//            make.width.mas_equalTo(0);
//            make.height.mas_equalTo(0);
//            
//        }];
//        //多少人打赏
//        [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
//            make.top.equalTo(self.btnNoZan.mas_bottom).offset(0);
//        }];
        //计算cell的高度
        [self.viewLineBasicViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.basicView.mas_centerX);
            make.top.equalTo(self.labCreatTime.mas_bottom).offset(25);
            make.bottom.equalTo(self.basicView.mas_bottom).offset(0);
            make.width.equalTo(self.basicView.mas_width);
            make.height.mas_equalTo(10);
        }];


    }else{
    
        
        //计算cell的高度
        [self.viewLineBasicViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.basicView.mas_centerX);
            make.top.equalTo(self.btnWin.mas_bottom).offset(20);
            make.bottom.equalTo(self.basicView.mas_bottom).offset(-(10 + 30 + 20 + 102 + 35));
            make.width.equalTo(self.basicView.mas_width);
            make.height.mas_equalTo(10);
        }];

        
        [self.labReason mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.viewLineBasicViewBottom.mas_bottom).offset(10);
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.height.mas_equalTo(30);
        }];

        [self.labcontentPart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.top.equalTo(self.labReason.mas_bottom).offset(0);
            make.right.equalTo(self.basicView.mas_right).offset(-15);

            make.size.mas_equalTo(CGSizeMake(Width - 30, 20));
        }];
        
        [self.imgcontentPart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labcontentPart.mas_bottom).offset(20);
            make.centerX.equalTo(self.basicView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(23, 23));
        }];
        [self.imghidecontent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labcontentPart.mas_bottom).offset(10);
            make.centerX.equalTo(self.basicView.mas_centerX);
            make.width.mas_equalTo(Width - 30);
        }];
        [self.labhidecontentPartDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgcontentPart.mas_bottom).offset(15);
            make.centerX.equalTo(self.basicView.mas_centerX);
        }];
//        [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.basicView.mas_right).offset(-15);
//            make.top.equalTo(self.imghidecontent.mas_bottom).offset(15);
//        }];
        [self.labcontentPartDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.basicView.mas_bottom);
//            make.top.equalTo(self.labCreatTime.mas_bottom).offset(15);
            make.left.equalTo(self.basicView.mas_left);
            make.size.mas_equalTo(CGSizeMake(Width, 35));
        }];
        
    }
    
    

    
    
}



- (void)addLikedHated:(UIButton *)btn
{
    
    //    param.put("type", "1"); //1 推荐曝料 2 评论
    //    param.put("targetId", "417"); ////点赞的对象id
    
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }
    if (btn.tag == 1) {
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }else if (btn.tag == 2){
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }
    
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [paremeter setObject:@"1" forKey:@"type"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_model.idId] forKey:@"targetId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)btn.tag] forKey:@"lclass"];
    
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_likeAdd] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                
                if (btn.tag == 1) {
                    _btnNoZan.selected = YES;
                    _model.like_count = _model.like_count + 1;
                    _model.liked = YES;
                    [_btnComment setTitle:[NSString stringWithFormat:@"共%ld人打赏",_model.like_count] forState:UIControlStateNormal];
                }else{
                    
                }
                
            }else{
                //                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
        }else
        {
            //            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        
    }];
}


//举报
- (void)report
{
//    return;
//    if (![Methods login]) {
//        [Methods toLogin];
//        
//        
//        return;
//    }
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"举报" message:@"选择类型" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"其他",@"抄袭作品",@"广告信息",@"反动政治",@"淫秽信息",@"骚扰信息", nil];
//        alert.delegate =self;
//        [alert show];
//        return;
//    }else{
//        
//        //param.put("type", "1"); //1 推荐曝料 2 评论
//        //param.put("category", "2"); //1 抄袭作品 2 广告信息 3 反动政治 4 淫秽信息 5 骚扰信息 6 其它
//        //param.put("targetId", "417"); //举报对象的id
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"举报" message:@"选择类型" preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alert addAction:[UIAlertAction actionWithTitle:@"抄袭作品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self sendReportInfomationWithcategory:@"1"];
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"广告信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self sendReportInfomationWithcategory:@"2"];
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"反动政治" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self sendReportInfomationWithcategory:@"3"];
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"淫秽信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self sendReportInfomationWithcategory:@"4"];
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"骚扰信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self sendReportInfomationWithcategory:@"5"];
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self sendReportInfomationWithcategory:@"0"];
//        }]];
//        
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }]];
//        
//        [APPDELEGATE.customTabbar presentToViewController:alert animated:YES completion:^{
//            
//        }];
//    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }
    [self sendReportInfomationWithcategory:[NSString stringWithFormat:@"%ld",(long)buttonIndex]];
    
}

- (void)sendReportInfomationWithcategory:(NSString *)category
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    //    [parameter setObject:@"1" forKey:@"type"];
    [parameter setObject:category forKey:@"type"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_model.idId] forKey:@"newsid"];
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_illegaladd] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ([[responseOrignal objectForKey:@"data"] integerValue] >0) {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"举报成功"];
            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
            
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}







@end
