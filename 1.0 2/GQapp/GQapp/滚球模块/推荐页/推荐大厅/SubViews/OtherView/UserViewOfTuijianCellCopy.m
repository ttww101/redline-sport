//
//  UserViewOfTuijianCell.m
//  GQapp
//
//  Created by WQ on 16/11/3.
//  Copyright © 1516年 GQXX. All rights reserved.
//
#import "UsermarkModel.h"
#import "MedalsModel.h"

#import "UserViewOfTuijianCellCopy.h"
@interface UserViewOfTuijianCellCopy()
@property (nonatomic, assign) BOOL addedAutoLayout;
@property (nonatomic, strong) UIView *basicView;
//头像
@property (nonatomic, strong) UIButton *btnAuthorPic;
//爆料者
@property (nonatomic, strong) UILabel *btnAuthor;
//头衔
@property (nonatomic, strong) UIImageView *imageSpace;

@property (nonatomic, strong) UIImageView *imageAuthorTitle;
@property (nonatomic, strong) UIImageView *imageAuthorTitle1;
@property (nonatomic, strong) UIImageView *imageAuthorTitle2;

//粉丝数 胜率 盈利率 场数
@property (nonatomic, strong) UIButton *imageFanTitle;
@property (nonatomic, strong) UILabel *labFanNum;

@property (nonatomic, strong) UIButton *imageWinTitle;
@property (nonatomic, strong) UILabel *labWinNum;

@property (nonatomic, strong) UIButton *imageProfitTitle;
@property (nonatomic, strong) UILabel *labProfitNum;

@property (nonatomic, strong) UIButton *imageRecommendTitle;
@property (nonatomic, strong) UILabel *labRecommendNum;


//右边只显示胜率和胜率文字
@property (nonatomic, strong) UILabel *labNewWinNum;
@property (nonatomic, strong) UILabel *labNewWinTitle;


//标记1 红色背景
@property (nonatomic, strong) UILabel *labRemark1;
//评论2
@property (nonatomic, strong) UILabel *labRemark2;

// 胜率
@property (nonatomic, strong) UILabel *userWin;



@property (nonatomic, strong) UILabel *labUserinfo;

// 用户等级
@property (nonatomic, strong) UILabel *userLeavel;

@property (nonatomic, strong) UILabel *goodPlay;


@property (nonatomic, assign) NSInteger Idid;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *pic;

@property (nonatomic, strong) UIView *viewLine;
@end
@implementation UserViewOfTuijianCellCopy

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (void)setValueWithUserTitle:(NSString *)title
                          Pic:(NSString *)pic
                    ArrTitles:(NSArray *)titls
                      Remark:(NSArray *)remark
                          Win:(NSString *)win
                      Profite:(NSString *)profite
                        Round:(NSString *)round
                         Fans:(NSString *)fans
                       Userid:(NSInteger)Idid
                    colorType:(NSInteger)type
                     cellType:(typeTuijianCell)celltype
                    readCount:(NSString *)readCount
                     dayRange:(NSString *)dayRange
                    WithModel:(TuijiandatingModel *)model
{
    
    if (!_addedAutoLayout) {
        _addedAutoLayout = YES;
        [self addAutoLayout];
    }
    

    _Idid = Idid;
    _nickName = title;
    _pic = pic;
    [_btnAuthor setText:title];
    _btnAuthor.tag = Idid;
    _btnAuthorPic.tag = Idid;
    
    [_btnAuthorPic sd_setBackgroundImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    [_btnAuthorPic sd_setBackgroundImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    
    if ( type== 2) {
        _labUserinfo.text = model.userinfo;
    }else{
        _labUserinfo.text = @"";

    }
    
    
    _labFanNum.text = fans;
    _labWinNum.text = win;
    _labProfitNum.text = profite;
    _labRecommendNum.text = round;
    _userLeavel.text = model.levelName;
    
    [_imageRecommendTitle setBackgroundImage:[UIImage imageNamed:@"tuijianCount"] forState:UIControlStateNormal];
    [_imageWinTitle setBackgroundImage:[UIImage imageNamed:@"tuijianWin"] forState:UIControlStateNormal];
    [_imageProfitTitle setBackgroundImage:[UIImage imageNamed:@"tuijianProfit"] forState:UIControlStateNormal];
    [_imageFanTitle setBackgroundImage:[UIImage imageNamed:@"tuijianFans"] forState:UIControlStateNormal];

//    NSString *winNumTitle = @"";
//    
//    if (celltype == typeTuijianCellDating) {
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"tuijianDTShowProfit"]) {
//            _labNewWinTitle.text = @"近7天盈利率";
//            winNumTitle = profite;
//        }else{
//            _labNewWinTitle.text = dayRange;
//            winNumTitle = win;
//        }
//
//    }else if (celltype == typeTuijianCellFirstPage){
//        
//        _labNewWinTitle.text = dayRange;
//        winNumTitle = win;
//
//        
//    }else if (celltype == typeTuijianCellFenxi){
//        
//        _labNewWinTitle.text = dayRange;
//        winNumTitle = win;
//        
//        
//    }else if (celltype == typeTuijianCellTuijianDetail){
//        
//        _labNewWinTitle.text = dayRange;
//        winNumTitle = win;
//        
//        
//    }else if (celltype == typeTuijianCellMybuy){
//        
//        _labNewWinTitle.text = dayRange;
//        winNumTitle = win;
//        
//        
//    }else {
//        _labNewWinTitle.text = dayRange;
//        winNumTitle = win;
//    }
//    
    
    
    
    
    
    
    
    
    [_imageAuthorTitle setImage:[UIImage imageNamed:@"clear"]];
    [_imageAuthorTitle1 setImage:[UIImage imageNamed:@"clear"]];
    [_imageAuthorTitle2 setImage:[UIImage imageNamed:@"clear"]];
    
//    if (titls.count == 0) {
//        [_imageSpace setBackgroundColor:[UIColor clearColor]];
//
//    }else{
//        [_imageSpace setBackgroundColor:[UIColor clearColor]];
//
//    }
    
    
    
    [titls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MedalsModel *medals = (MedalsModel*)obj;
        switch (idx) {
            case 0:
            {
                [_imageAuthorTitle sd_setImageWithURL:[NSURL URLWithString:medals.url]];
            }
                break;
            case 1:
            {
                [_imageAuthorTitle1 sd_setImageWithURL:[NSURL URLWithString:medals.url]];
            }
                break;
            case 2:
            {
                [_imageAuthorTitle2 sd_setImageWithURL:[NSURL URLWithString:medals.url]];
            }
                break;
                
            default:
                break;
        }
        
    }];
    

    if ([model.remark containsString:@":"]) {
        _labRemark1.hidden = false;
        _labRemark2.hidden = false;
        _userWin.hidden = YES;
        NSArray *titleArray = [model.remark componentsSeparatedByString:@":"];
        NSString *firstStr = [titleArray firstObject];
        NSString *lastStr = [titleArray lastObject];
        _labRemark2.text = firstStr;
        _labRemark1.text = lastStr;
        
        
    } else {
        _labRemark1.hidden = YES;
        _labRemark2.hidden = YES;
        if (model.remark.length > 0) {
            _userWin.hidden = false;
            _userWin.text = model.remark;
        } else {
            _userWin.hidden = YES;
        }
    }
    
    
    NSString *goodPlay = @"擅长:";
    NSString *firstStr = nil;
    NSString *secondStr = nil;
    if (model.sclassWinRate.length > 0) {
        firstStr = [NSString stringWithFormat:@"%@:%@%%",model.goodSclass,model.sclassWinRate];
    }
    
    if (model.playWinRate.length > 0) {
        NSString *playType = @"";
        if (model.goodPlay == 1) {
            playType = @"胜平负:";
        } else if (model.goodPlay == 2) {
            playType = @"让球:";
        } else if (model.goodPlay == 3) {
            playType = @"大小球:";
        }
        secondStr = [NSString stringWithFormat:@"%@%@%%",playType,model.playWinRate];
    }
    if (!firstStr && !secondStr) {
        _goodPlay.hidden = YES;
    } else {
        _goodPlay.hidden = false;
        goodPlay = [goodPlay stringByAppendingString:[NSString stringWithFormat:@"%@%@",PARAM_IS_NIL_ERROR(firstStr), PARAM_IS_NIL_ERROR(secondStr)]];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:goodPlay];
        [att addAttribute:NSFontAttributeName value:font11 range:[goodPlay rangeOfString:goodPlay]];
        [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0x999999) range:[goodPlay rangeOfString:goodPlay]];
        if (firstStr) {
            [att addAttribute:NSForegroundColorAttributeName value:redcolor range:[goodPlay rangeOfString:[NSString stringWithFormat:@"%@%%",model.sclassWinRate]]];
        }
        
        if (secondStr) {
            [att addAttribute:NSForegroundColorAttributeName value:redcolor range:[goodPlay rangeOfString:[NSString stringWithFormat:@"%@%%",model.playWinRate]]];
        }
        _goodPlay.attributedText = att;
    }
    
    
}


- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAuther)];
        [_basicView addGestureRecognizer:tap];
        [_basicView addSubview:self.btnAuthorPic];
        [_basicView addSubview:self.btnAuthor];
        [_basicView addSubview:self.imageSpace];
        [_basicView addSubview:self.imageAuthorTitle];
        [_basicView addSubview:self.imageAuthorTitle1];
        [_basicView addSubview:self.imageAuthorTitle2];
        [_basicView addSubview:self.labRemark1];
        [_basicView addSubview:self.labRemark2];
        [_basicView addSubview:self.imageWinTitle];
        [_basicView addSubview:self.labWinNum];
        [_basicView addSubview:self.imageProfitTitle];
        [_basicView addSubview:self.labProfitNum];
        [_basicView addSubview:self.imageFanTitle];
        [_basicView addSubview:self.labFanNum];
        [_basicView addSubview:self.labRecommendNum];
        [_basicView addSubview:self.imageRecommendTitle];
        [_basicView addSubview:self.labUserinfo];

        [_basicView addSubview:self.labNewWinTitle];
        [_basicView addSubview:self.labNewWinNum];
        [_basicView addSubview:self.viewLine];
        [_basicView addSubview:self.userLeavel];
        [_basicView addSubview:self.userWin];
        [_basicView addSubview:self.goodPlay];
    }
    return _basicView;
}

- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorCellLine;
    }
    return _viewLine;
}

- (UIButton *)btnAuthorPic
{
    if (!_btnAuthorPic) {
        _btnAuthorPic = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAuthorPic.layer.cornerRadius = 40/2;
        _btnAuthorPic.layer.masksToBounds = YES;
        _btnAuthorPic.clipsToBounds = YES;
        _btnAuthorPic.userInteractionEnabled = NO;
//        [_btnAuthorPic addTarget:self action:@selector(toAuther) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAuthorPic;
}
- (UILabel *)btnAuthor
{
    if (!_btnAuthor) {
        _btnAuthor = [[UILabel alloc] init];
        _btnAuthor.font = BoldFont4(fontSize15);
        [_btnAuthor setTextColor:color33];
//        [_btnAuthor addTarget:self action:@selector(toAuther) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnAuthor;
    
}

- (UILabel *)labUserinfo
{
    if (!_labUserinfo) {
        _labUserinfo = [[UILabel alloc] init];
        _labUserinfo.textColor = color33;
        _labUserinfo.font = font12;
        _labUserinfo.numberOfLines = 1;
    }
    return _labUserinfo;
}

- (UIImageView *)imageSpace
{
    if (!_imageSpace) {
        _imageSpace = [[UIImageView alloc] init];
        _imageSpace.backgroundColor = grayColor2;
//        _imageSpace.image = [UIImage imageNamed:@"blue1"];

    }
    return _imageSpace;
}
- (UIImageView *)imageAuthorTitle
{
    if (!_imageAuthorTitle) {
        _imageAuthorTitle = [[UIImageView alloc] init];
//                _imageAuthorTitle.image = [UIImage imageNamed:@"red"];
    }
    return _imageAuthorTitle;
}
- (UIImageView *)imageAuthorTitle1
{
    if (!_imageAuthorTitle1) {
        _imageAuthorTitle1 = [[UIImageView alloc] init];
//        _imageAuthorTitle1.image = [UIImage imageNamed:@"red"];
    }
    return _imageAuthorTitle1;
}
- (UIImageView *)imageAuthorTitle2
{
    if (!_imageAuthorTitle2) {
        _imageAuthorTitle2 = [[UIImageView alloc] init];
//                _imageAuthorTitle2.image = [UIImage imageNamed:@"red"];
    }
    return _imageAuthorTitle2;
}

- (UIButton *)imageFanTitle
{
    if (!_imageFanTitle) {
        _imageFanTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageFanTitle.userInteractionEnabled = NO;
        _imageFanTitle.hidden = YES;

    }
    return _imageFanTitle;
}
- (UIButton *)imageWinTitle
{
    if (!_imageWinTitle) {
        _imageWinTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageWinTitle.userInteractionEnabled = NO;
        _imageWinTitle.hidden = YES;
    }
    return _imageWinTitle;
}
- (UIButton *)imageProfitTitle
{
    if (!_imageProfitTitle) {
        _imageProfitTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageProfitTitle.userInteractionEnabled = NO;
        _imageProfitTitle.hidden = YES;

    }
    return _imageProfitTitle;
}

- (UIButton *)imageRecommendTitle
{
    if (!_imageRecommendTitle) {
        _imageRecommendTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageRecommendTitle.userInteractionEnabled = NO;
         _imageRecommendTitle.hidden = YES;

    }
    return _imageRecommendTitle;
}



- (UILabel *)labFanNum
{
    if (!_labFanNum) {
        _labFanNum = [[UILabel alloc] init];
        _labFanNum.font = font11;
        _labFanNum.textColor = color66;
        _labFanNum.hidden = YES;
        //        _labProfitNum.backgroundColor = redcolor;
    }
    return _labFanNum;
}

- (UILabel *)labProfitNum
{
    if (!_labProfitNum) {
        _labProfitNum = [[UILabel alloc] init];
        _labProfitNum.font = font11;
        _labProfitNum.textColor = color66;
        _labProfitNum.hidden = YES;
        //        _labProfitNum.backgroundColor = redcolor;
    }
    return _labProfitNum;
}

- (UILabel *)labWinNum
{
    if (!_labWinNum) {
        _labWinNum = [[UILabel alloc] init];
        _labWinNum.font = font11;
        _labWinNum.textColor = color66;
        _labWinNum.hidden = YES;
        
    }
    return _labWinNum;
}
- (UILabel *)labRecommendNum
{
    if (!_labRecommendNum) {
        _labRecommendNum = [[UILabel alloc] init];
        _labRecommendNum.font = font11;
        _labRecommendNum.textColor = color66;
         _labRecommendNum.hidden = YES;
        
    }
    return _labRecommendNum;
}

- (UILabel *)userWin
{
    if (!_userWin) {
        _userWin = [[UILabel alloc] init];
        _userWin.font = font14;
        _userWin.textColor = [UIColor whiteColor];
        _userWin.layer.cornerRadius =3;
        _userWin.layer.masksToBounds = YES;
        _userWin.backgroundColor = redcolor;
        _userWin.textAlignment = NSTextAlignmentCenter;
    }
    return _userWin;
}

- (UILabel *)labRemark1
{
    if (!_labRemark1) {
        _labRemark1 = [[UILabel alloc] init];
        _labRemark1.font = font18;
        _labRemark1.textColor = redcolor;

    }
    return _labRemark1;
}

- (UILabel *)labRemark2
{
    if (!_labRemark2) {
        _labRemark2 = [[UILabel alloc] init];
        _labRemark2.font = font11;
        _labRemark2.textColor = UIColorFromRGBWithOX(0x999999);

    }
    return _labRemark2;
}

- (UILabel *)labNewWinNum
{
    if (!_labNewWinNum) {
        _labNewWinNum = [[UILabel alloc] init];
        _labNewWinNum.font = font24;
        
    }
    return _labNewWinNum;
}

- (UILabel *)labNewWinTitle
{
    if (!_labNewWinTitle) {
        _labNewWinTitle = [[UILabel alloc] init];
        _labNewWinTitle.font = font10;
    }
    return _labNewWinTitle;
}

- (UILabel *)userLeavel {
    if (_userLeavel == nil) {
        _userLeavel = [[UILabel alloc] init];
        _userLeavel.font = font10;
    }
    return _userLeavel;
}

- (UILabel *)goodPlay {
    if (_goodPlay == nil) {
        _goodPlay = [[UILabel alloc] init];
        _goodPlay.font = font12;
        _goodPlay.text = @"擅长";
    }
    return _goodPlay;
}

- (void)addAutoLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.btnAuthorPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(9);
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    [self.btnAuthor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthorPic.mas_right).offset(9);
        make.top.equalTo(self.basicView.mas_top).offset(9);
    }];
    
    [self.imageSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthor.mas_right).offset(12);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(1);
        
    }];
    
    [self.userLeavel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageSpace.mas_right).offset(12);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
    }];
    
    [self.imageAuthorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageSpace.mas_right).offset(12);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(0);

    }];
    [self.imageAuthorTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageAuthorTitle.mas_right).offset(10);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(0);
        
    }];
    [self.imageAuthorTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageAuthorTitle1.mas_right).offset(10);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(0);
        
    }];

    [self.labRemark1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-26);
        make.top.equalTo(self.basicView.mas_top).offset(10);
    }];
    
    [self.userWin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-26);
        make.top.equalTo(self.basicView.mas_top).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    [self.labRemark2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labRemark1.mas_right);
        make.top.equalTo(self.labRemark1.mas_bottom).offset(0);
    }];
    
    [self.goodPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthorPic.mas_right).offset(9);
        make.top.equalTo(self.btnAuthor.mas_bottom).offset(10);
    }];
    
    [self.imageRecommendTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthorPic.mas_right).offset(9);
        make.top.equalTo(self.btnAuthor.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.labRecommendNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageRecommendTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    
    [self.imageWinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labRecommendNum.mas_right).offset(11);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.labWinNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageWinTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    
    [self.imageProfitTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labWinNum.mas_right).offset(11);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.labProfitNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageProfitTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    
    [self.imageFanTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labProfitNum.mas_right).offset(11);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.labFanNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageFanTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    
    
    
    
    
    [self.labNewWinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-5.5);
        make.centerX.equalTo(self.labNewWinNum.mas_centerX).offset(0);
    }];
    
    [self.labNewWinNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.labNewWinTitle.mas_top).offset(-2.5);
        make.right.equalTo(self.basicView.mas_right).offset(-31);

    }];

    
    [self.labUserinfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-10);
        make.width.mas_equalTo(Width - 30);
    }];
    
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];

}

- (void)toAuther
{
    if (_Idid == 1) {
        return;
    }
     UserViewController *userVC = [[UserViewController alloc] init];
    userVC.userId = _Idid;
    userVC.userName = _nickName;
    userVC.userPic = _pic;
    userVC.Number=1;
    userVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
}


























@end
